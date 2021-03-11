# Lattice materials

## Linear 3D
* __linear_3D.edp__

## Non linear 2D
* __tensile.edp__: problema lineare di Micheletti, senza condizioni periodiche ???? (con convect nel problema primale, quindi no buono)
* __tensile_periodico.edp__: problema lineare di Micheletti, no adaptation, no ipopt, calcolo di nu tramite v (formula 3 paper non lineare Sigmund) usando convect (->possibile J func?)
* __tensile_BC.edp__: modello lineare di Michelletti con BC di Ferro (non vanno bene)
* __tensile_nu.edp__: modello lineare di Micheletti con calcolo nu diverso (ok)
* __tensile_BC_nu.edp__: modello lineare di Micheletti con BC di Ferro e calcolo nu diverso (non va bene)
* __ff_non_linear.edp__: problema non lineare dalla documentazione di FreeFem
* __tensile_non_linear.edp__: problema di dilatazione di Micheletti nel modello non lineare di FreeFem (non proverei anche con BC di Ferro) (prova ricondotto al lineare: coeff nl)
* __tensile_non_linear1.edp__: problema di dilatazione di Micheletti col modello non lineare nostro con energia1
* __tensile_non_linear2.edp__: problema di dilatazione di Micheletti col modello non lineare nostro con energia4
* __nonlinear1.edp__: modifica problema case1 con modello non lineare ottenuto tramite paper Sigmund e KS (modello nostro) (probabilmente i nomi con _ sono da cambiare), direi con energia1 (iniziato ma interrotto perchè scrivendo i pb primali componente per componente non ci tornavano cose)
* __nonlinear2.edp__: modifica problema case1 con modello non lineare ottenuto tramite paper Sigmund e KS (modello nostro), con energia4

LINK EXAMPLE: [Vai a Google](https://www.google.com)
![Google](https://www.google.it/images/branding/googlelogo/2x/googlelogo_color_160x56dp.png)

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

<img src='https://g.gravizo.com/svg?%20%20digraph%20G%20%7B%0A%20%20%20%20subgraph%20cluster_case1_linear%20%7B%0A%20%20%20%20label%3D%22LINEAR%22%0A%20%20%20%20case1%0A%20%20%20%20%7D%0A%20%20%20%20subgraph%20cluster_case1_non_linear%20%7B%0A%20%20%20%20label%3D%22NON%20LINEAR%22%0A%20%20%20%20case1%20-%3E%20case1_nonlinear1%20-%3E%20case1_nonlinear2%3B%0A%20%20%20%20%7D%0A%20%20%20%20subgraph%20cluster_linear%20%7B%0A%20%20%20%20%20%20label%3D%22LINEAR%22%0A%20%20%20%20%20%20tensile%3B%0A%20%20%20%20%20%20tensile_periodico%20-%3E%20tensile_BC%20-%3E%20tensile_BC_nu%3B%0A%20%20%20%20%20%20tensile_periodico%20-%3E%20tensile_nu%20-%3E%20tensile_BC_nu%3B%0A%20%20%20%20%7D%0A%20%20%20%20subgraph%20cluster_non_linear%20%7B%0A%20%20%20%20%20%20label%3D%22NON%20LINEAR%22%0A%20%20%20%20%20%20tensile_BC_nu%20-%3E%20tensile_non_linear%3B%0A%20%20%20%20%20%20ff_non_linear%20-%3E%20tensile_non_linear%20-%3E%20tensile_non_linear_e1%3B%0A%20%20%20%20%20%20tensile_non_linear%20-%3E%20tensile_non_linear_e4%3B%0A%20%20%20%20%7D%0A%20%20%7D
'>
