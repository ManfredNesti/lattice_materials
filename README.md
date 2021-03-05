# Lattice materials

## Linear 3D
* __linear_3D.edp__

## Non linear 2D
* __tensile.edp__: problema lineare di Micheletti, senza condizioni periodiche ???? (con convect nel problema primale, quindi no buono)
* __tensile_periodico.edp__: problema lineare di Micheletti, no adaptation, no ipopt, calcolo di nu tramite v (formula 3 paper non lineare Sigmund) usando convect (->possibile J func?)
* __tensile_BC.edp__: modello lineare di Michelletti con BC di Ferro
* __tensile_nu.edp__: modello lineare di Micheletti con calcolo nu diverso
* __tensile_BC_nu.edp__: modello lineare di Micheletti con BC di Ferro e calcolo nu diverso
* __ff_non_linear__: problema non lineare dalla documentazione di FreeFem
* __tensile_non_linear__: problema di dilatazione di Micheletti nel modello non lineare di FreeFem (provare anche con BC di Ferro)
* __(third_try.edp__: pb primale con nostro modello, BC suggerite da ferro 26/01)
* __nonlinear1.edp__: modifica problema case1 con modello non lineare ottenuto tramite paper Sigmund e Xia (modello nostro) (probabilmente i nomi con _ sono da cambiare), direi con energia1 (iniziato ma interrotto perchè scrivendo i pb primali componente per componente non ci tornavano cose)
* __nonlinear2.edp__: modifica problema case1 con modello non lineare ottenuto tramite paper Sigmund e Xia (modello nostro), con energia4

## Hints
Plottando sigma vs epsilon (? interpretazione grafici di Sigmund è problematica), dovrebbe venire una retta indep da u0
Settare rho = 1 su tutto il dominio
Imporre i dati e le BC
Lanciare il problema primale e vedere gli spostamenti u (e calcolare nu)

__BCs__:

* __Bordo sopra__: Neumann omogeneo
* __Bordo sotto__: Neumann omogeneo
* __Bordo destro__: trazione = Dirichlet u = [u0 , 0]  -> v = int1d(bordo di sopra) (u)/ lunghezza_bordo di sopra (per convertire valore nodale in un valore singolo sul bordo di sopra)
* __Bordo sinistro__: simmetria u.n = 0
