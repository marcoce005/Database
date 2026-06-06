import streamlit as st
import re
from datetime import time
from utils.utils import *

st.title(":orange[Inserire nuova lezione settimanale]")
st.subheader(":orange[Programmazione delle lezioni settimanali]")
st.caption(
    "Questa pagina permette di inserire nuove lezioni nella tabella PROGRAMMA tramite un form guidato. "
    "L’utente può selezionare istruttore e corso da menu a tendina popolati dinamicamente dal database, "
    "e inserire i restanti dati tramite widget dedicati (come slider e campi testuali). "
    "Il sistema applica diversi controlli di validità, tra cui la durata massima delle lezioni, "
    "la corretta selezione del giorno della settimana e la verifica dell’assenza di conflitti con altre lezioni già programmate. "
    "L’inserimento viene confermato solo se tutti i vincoli sono rispettati, altrimenti viene mostrato un messaggio di errore dettagliato."
)

if check_connection():
    query = "SELECT Istruttore.CodFisc, Istruttore.Nome, Istruttore.Cognome FROM Istruttore ORDER BY Istruttore.Nome;"
    instructures = [
        {"label": f"{e[1]} {e[2]}", "value": e[0]}
        for e in execute_query(st.session_state["connection"], query)
    ]

    query = "SELECT Corsi.CodC, Corsi.Nome FROM Corsi ORDER BY Corsi.Nome;"
    courses = [
        {"label": e[1], "value": e[0]}
        for e in execute_query(st.session_state["connection"], query)
    ]

    days = ["Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì"]

    with st.form("new_program"):
        data_form = {
            "CF": st.selectbox(
                "Istruttore", options=instructures, format_func=lambda x: x["label"]
            )["value"],
            "Giorno": st.selectbox("Giorno della settimana", options=days),
            "OraInizio": st.slider(
                "Orario Inizio", min_value=time(9, 0), max_value=time(18, 0)
            ).strftime("%H:%M:%S"),
            "Durata": st.slider("Durata attività", min_value=15, max_value=60, step=5),
            "CodC": st.selectbox(
                "Corso", options=courses, format_func=lambda x: x["label"]
            )["value"],
            "Sala": st.text_input("Sala", placeholder="SXXX"),
        }
        submit = st.form_submit_button("Invia")

    if submit:
        if re.match(r"^S\d+$", data_form["Sala"]) is None:
            st.warning("Sala non valida formato: S + numero")
        else:
            query = f"SELECT COUNT(*) FROM Programma WHERE Programma.CodC = '{data_form['CodC']}' AND Programma.Giorno LIKE '{data_form['Giorno'][0:-1]}%';"
            occupy = bool(
                execute_query(st.session_state["connection"], query).first()[0]
            )

            if occupy:
                value_to_label = {e["value"]: e["label"] for e in courses}
                st.warning(
                    f"Nel giorno {data_form['Giorno']} è già presente l'attività di {value_to_label.get(data_form['CodC'])}"
                )
            else:
                query = f"INSERT INTO Programma(`CodFisc`, `Giorno`, `OraInizio`, `Durata`, `CodC`, `Sala`) VALUES({", ".join(repr(e) for e in data_form.values())})"

                try:
                    execute_query(st.session_state["connection"], query)
                    st.session_state["connection"].commit()
                    st.toast(
                        "Programma aggiunto nel database con successo. ",
                        icon="\u2705",
                        duration="short",
                    )
                except Exception as exc:
                    st.session_state["connection"].rollback()
                    st.error(exc)

else:
    st.warning("Connettersi al database. ")
