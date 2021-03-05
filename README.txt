LINEAR 3D
---
linear_3D.edp
---


NON LINEARE 2D
---
tensile.edp: problema lineare di Micheletti, senza condizioni periodiche ???? (con convect nel problema primale, quindi no buono)
---
tensile_periodico.edp: problema lineare di Micheletti, no adaptation, no ipopt, calcolo di nu tramite v (formula 3 paper non lineare Sigmund) usando convect (->possibile J func?)
---
tensile_BC.edp: modello lineare di Michelletti con BC di Ferro
---
tensile_nu.edo: modello lineare di Micheletti con calcolo nu diverso
---
tensile_BC_nu.edo: modello lineare di Micheletti con BC di Ferro e calcolo nu diverso
---
ff_non_linear: problema non lineare dalla documentazione di FreeFem
---
tensile_non_linear: problema di dilatazione di Micheletti nel modello non lineare di FreeFem (provare anche con BC di Ferro)
---
(third_try.edp: pb primale con nostro modello, BC suggerite da ferro 26/01)
---
nonlinear1.edp: modifica problema case1 con modello non lineare ottenuto tramite paper Sigmund e Xia (modello nostro) (probabilmente i nomi con _ sono da cambiare), direi con energia1 (iniziato ma interrotto perchè scrivendo i pb primali componente per componente non ci tornavano cose)
---
nonlinear2.edp: modifica problema case1 con modello non lineare ottenuto tramite paper Sigmund e Xia (modello nostro), con energia4
---

Hints
--
Plottando sigma vs epsilon (? interpretazione grafici di Sigmund è problematica), dovrebbe venire una retta indep da u0
Settare rho = 1 su tutto il dominio
Imporre i dati e le BC
Lanciare il problema primale e vedere gli spostamenti u (e calcolare nu)

BCs:
Bordo sopra: Neumann omogeneo
Bordo sotto: Neumann omogeneo
Bordo destro: trazione = Dirichlet u = [u0 , 0]  -> v = int1d(bordo di sopra) (u)/ lunghezza_bordo di sopra (per convertire valore nodale in un valore singolo sul bordo di sopra)
Bordo sinistro: simmetria u.n = 0
