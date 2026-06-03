import streamlit as st
import numpy as np
import pandas as pd
from utils.utils import *

st.set_page_config(
    page_title="Homework 04", layout="wide", initial_sidebar_state="expanded"
)


st.title(":green[Homework 04]")

st.markdown("### Obbiettivo")
st.markdown(
    "Creare un’applicazione multi-pagina per visualizzare le principali informazioni contenute nel database e permettere all’utente di aggiungerne di nuove."
)
st.markdown("Created by Marco Cellini. ")


if "connection" not in st.session_state.keys():
    st.session_state["connection"] = False

if check_connection():
    st.markdown("### Lezioni per slot di tempo")
    query = "SELECT Programma.OraInizio, COUNT(*) AS TotLez FROM Programma GROUP BY Programma.OraInizio ORDER BY Programma.OraInizio; "
    ora_n_lez = pd.DataFrame(execute_query(st.session_state["connection"], query))
    st.area_chart(
        ora_n_lez,
        x="OraInizio",
        x_label="Orario inizio",
        y_label="Numero lezioni",
        color="#55b500",
    )

    st.markdown("### Lezioni per giorno")
    query = "SELECT Programma.Giorno, COUNT(*) AS TotLez FROM Programma GROUP BY Programma.Giorno;"
    giorno_n_lez = pd.DataFrame(execute_query(st.session_state["connection"], query))
    giorno_n_lez["Giorno"] = giorno_n_lez["Giorno"].str.replace("Ã¬", "ì")
    st.bar_chart(
        giorno_n_lez, x="Giorno", y_label="Numero lezioni", sort=False, color="#238300"
    )
