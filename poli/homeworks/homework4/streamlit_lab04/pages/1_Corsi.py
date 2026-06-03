import streamlit as st
import numpy as np
import pandas as pd
from utils.utils import *

st.title(":red[Corsi]")

cols = st.columns(2)

if check_connection():
    query = "SHOW COLUMNS FROM Corsi;"
    table_infos = pd.DataFrame(execute_query(st.session_state["connection"], query))[
        "Field"
    ]

    query = "SELECT COUNT(*) AS TotCorsi FROM `Corsi`;"
    n_corsi = execute_query(st.session_state["connection"], query).mappings().first()
    cols[0].metric("Numero di Corsi", n_corsi["TotCorsi"])

    query = "SELECT COUNT(DISTINCT Corsi.Tipo) AS nTipi FROM Corsi; "
    n_tipi = execute_query(st.session_state["connection"], query).mappings().first()
    cols[1].metric("Numero di Tipi", n_tipi["nTipi"])

    selected = st.multiselect(
        "Informazioni",
        table_infos,
        default=table_infos,
        placeholder="Selezionare le informazioni da stampare",
    )
    range_selected = st.select_slider("Livello Difficoltà", [1, 2, 3, 4], value=(1, 4))
    query = f"SELECT {", ".join(selected)} FROM Corsi WHERE Livello >= {range_selected[0]} AND Livello <= {range_selected[1]}"

    if len(selected) == 0:
        st.error("Non hai selezionato niente. ")
    else:
        corsi_selected_by_level = pd.DataFrame(
            execute_query(st.session_state["connection"], query)
        )

        if corsi_selected_by_level.empty:
            st.warning("La ricerca non ha ritornato niente. ")
        else:
            st.write(corsi_selected_by_level)

    with st.expander("Programmi", expanded=True):
        if len(selected) == 0:
            st.error("Non hai selezionato niente. ")
        else:
            query = f"SELECT * FROM Corsi WHERE Livello >= {range_selected[0]} AND Livello <= {range_selected[1]}"
            corsi_selected_by_level = pd.DataFrame(
                execute_query(st.session_state["connection"], query)
            )
            if corsi_selected_by_level.empty:
                st.warning("La ricerca non ha ritornato niente. ")
            else:
                for e in corsi_selected_by_level.itertuples(index=True):
                    st.markdown(f"##### {e.Nome} [{e.CodC}]")
                    query = f"SELECT Istruttore.CodFisc, Istruttore.Nome, Istruttore.Cognome, Istruttore.Email, Giorno, Durata, Sala FROM Programma, Istruttore WHERE Programma.CodC = '{e.CodC}' AND Istruttore.CodFisc = Programma.CodFisc;"
                    possible_program = pd.DataFrame(
                        execute_query(st.session_state["connection"], query)
                    )
                    if len(possible_program) == 0:
                        st.warning(f"Nessun programma trovato per il corso: {e.CodC}. ")
                    else:
                        st.write(possible_program)
