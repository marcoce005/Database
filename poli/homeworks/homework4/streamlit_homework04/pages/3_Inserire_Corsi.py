import streamlit as st
import re
from utils.utils import *


def valid_form(data):
    if re.match(r"^CT\d+$", data["CodC"]) is None:
        return (False, "Codice Corso non valido [formato: CT + numero]")
    if data["Nome"] == "":
        return (False, "Campo Nome Corso incompleto. ")
    if data["Tipo"] == "":
        return (False, "Campo Tipo di Corso incompleto. ")
    return (True, "")


st.title(":violet[Inserire nuovi Corsi]")
st.subheader(":violet[Inserimento di nuovi corsi]")
st.caption(
    "Questa pagina consente di aggiungere nuovi corsi al database tramite un form guidato. "
    "L’utente deve inserire tutte le informazioni richieste (CodC, Nome, Tipo e Livello), "
    "con controlli automatici sulla validità dei dati: il codice deve iniziare con 'CT', "
    "il livello deve essere un numero intero compreso tra 1 e 4 e tutti i campi devono essere compilati. "
    "Il sistema gestisce eventuali errori di inserimento, come dati mancanti o chiavi duplicate, "
    "mostrando un messaggio di errore oppure una conferma in caso di inserimento corretto."
)

db_connected = check_connection()

with st.form("new_course"):
    data_form = {
        "CodC": st.text_input("Codice Corso", placeholder="CTXXX").upper(),
        "Nome": st.text_input("Nome Corso"),
        "Tipo": st.text_input("Tipo di Corso"),
        "Livello": st.number_input("Livello di Difficoltà", min_value=1, max_value=4),
    }
    submit = st.form_submit_button("Invia")

check_form = valid_form(data_form)

if submit and check_form[0]:
    if db_connected:
        query = f"INSERT INTO Corsi(`CodC`, `Nome`, `Tipo`, `Livello`) VALUES({", ".join(repr(e) for e in data_form.values())})"
        try:
            execute_query(st.session_state["connection"], query)
            st.session_state["connection"].commit()
            st.toast(
                "Corso aggiunto nel database con successo. ",
                icon="\u2705",
                duration="short",
            )
        except Exception as exc:
            if "Duplicate entry" in str(exc):
                st.error("Codice del corso già presente. ")
            else:
                st.error(exc)
            st.session_state["connection"].rollback()

    else:
        st.error("Errore nella connessione al database. ")
elif submit:
    st.error(check_form[1])
