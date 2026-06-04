import streamlit as st
import pandas as pd
from utils.utils import *
import datetime

st.title(":yellow[Istruttori]")

if check_connection():
    surname = st.text_input("Cognome").title()
    range_date = st.date_input("Range data di nascita", (datetime.date(1970, 1, 1), datetime.datetime.now()), max_value=datetime.datetime.now())
    query = f"SELECT * FROM Istruttore WHERE Cognome LIKE '{surname}%' AND DataNascita >= '{range_date[0]}' AND DataNascita <= '{range_date[1]}';"
    selected_instructurs = pd.DataFrame(execute_query(st.session_state["connection"], query))
    
    if selected_instructurs.empty:
        st.warning("La ricerca non ha ritornato niente. ")
    else:
        for i, e in selected_instructurs.iterrows():
            st.markdown(f" - :yellow[{e.Nome} {e.Cognome}]")
            st.markdown(f"Codice Fiscale: {e.CodFisc}")
            st.markdown(f"Data di Nascita: {e.DataNascita}")
            st.markdown(f"Email: {e.Email}")
            st.markdown(f"Numero di Telefono: {e.Telefono}")