import streamlit as st
import numpy as np
import pandas as pd
from utils.utils import *

st.title(":blue[Stanze]")

if check_connection():
    with st.expander("Filtri", True):
        room_type = st.radio("Tipo di Stanza", ["Singola", "Doppia", "Tripla", "Tutte"])
        
        st.multiselect("Optional", [])
        st.write(room_type)