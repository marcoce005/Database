import streamlit as st
import numpy as np
import pandas as pd
from utils.utils import *

st.title(":blue[Agenzie]")

cols = st.columns(3)

if check_connection():
    # Extract number of agencies
    query = "SELECT COUNT(*) AS `nAgenzie` FROM `AGENZIA`"
    n_agenzie = execute_query(st.session_state["connection"], query)
    cols[0].metric("Numero di Agenzie", n_agenzie.mappings().first()["nAgenzie"])

    # Extract number of cities
    query = "SELECT COUNT(*) AS `nCitta` FROM `CITTA`"
    n_agenzie = execute_query(st.session_state["connection"], query)
    cols[1].metric("Numero di Città", n_agenzie.mappings().first()["nCitta"])

    # Extract city with most agencies
    query = "SELECT C.Nome, COUNT(*) AS nAgenzie FROM `AGENZIA` A, `CITTA` C WHERE A.Citta_Indirizzo = C.Nome GROUP BY C.Nome ORDER BY nAgenzie DESC LIMIT 1"
    n_agenzie = execute_query(st.session_state["connection"], query)
    cols[2].metric("Città con più Agenzie", n_agenzie.mappings().first()["Nome"])
