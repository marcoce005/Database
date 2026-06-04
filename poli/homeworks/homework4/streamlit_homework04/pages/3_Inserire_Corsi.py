import streamlit as st
from utils.utils import *


def valid_form(data):
    if data["CodC"][0:2] != "CT" or data["Nome"] == "" or data["Tipo"] == "":
        return False
    return True


st.title(":violet[Inserire nuovi Corsi]")
db_connected = check_connection()

with st.form("new_course"):
    data_form = {
        "CodC": st.text_input("Codice Corso", placeholder="CTXXX").upper(),
        "Nome": st.text_input("Nome Corso"),
        "Tipo": st.text_input("Tipo di Corso"),
        "Livello": st.number_input("Livello di Difficoltà", min_value=1, max_value=4),
    }
    submit = st.form_submit_button("Invia")

if submit and valid_form(data_form):
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
    st.error("Errore nei campi del form. ")
