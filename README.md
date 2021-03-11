# Lattice materials

## Non linear 2D

![Graph](https://g.gravizo.com/svg?digraph%20G%20%7B%0A%20%20subgraph%20cluster_case1_linear%20%7B%0A%20%20label%3D%22LINEAR%22%0A%20%20case1%0A%20%20%7D%0A%0A%20%20subgraph%20cluster_case1_non_linear%20%7B%0A%20%20label%3D%22NON%20LINEAR%22%0A%20%20case1%20-%3E%20case1_non_linear1%20-%3E%20case1_non_linear2%3B%0A%20%20%7D%0A%0A%20%20subgraph%20cluster_linear%20%7B%0A%20%20%20%20label%3D%22LINEAR%22%0A%20%20%20%20tensile%20-%3E%20tensile_BC%20-%3E%20tensile_BC_nu%3B%0A%20%20%20%20tensile%20-%3E%20tensile_nu%20-%3E%20tensile_BC_nu%3B%0A%20%20%7D%0A%0A%20%20subgraph%20cluster_non_linear%20%7B%0A%20%20%20%20label%3D%22NON%20LINEAR%22%0A%20%20%20%20tensile_BC_nu%20-%3E%20tensile_non_linear%3B%0A%20%20%20%20ff_non_linear%20-%3E%20tensile_non_linear%20-%3E%20tensile_non_linear_e1%3B%0A%20%20%20%20tensile_non_linear%20-%3E%20tensile_non_linear_e4%3B%0A%20%20%7D%0A%7D%0A)

* __tensile.edp__: problema lineare di Micheletti, nu calcolato con convect
* __tensile_BC.edp__: modello lineare di Michelletti, nu calcolato con convect, BC di Nicola
* __tensile_nu.edp__: modello lineare di Micheletti, nu calcolato con formula 3 paper non lineare Sigmund
* __tensile_BC_nu.edp__: modello lineare di Micheletti, BC di Nicola, nu calcolato con formula 3 paper non lineare Sigmund
* __ff_non_linear.edp__: problema non lineare dalla documentazione di FreeFem
* __tensile_non_linear.edp__: stesso problema di trazione di Micheletti nel modello non lineare di FreeFem, f(F2) = F2, parametro nl = {0: lineare, 1: non lineare}
* __tensile_non_linear_e1.edp__: stesso problema di trazione di Micheletti col modello non lineare nostro con energia1
* __tensile_non_linear_e2.edp__: stesso problema di trazione di Micheletti col modello non lineare nostro con energia4
* __case1_non_linear1.edp__: modifica problema case1 con modello non lineare ottenuto tramite paper Sigmund e KS (modello nostro) (probabilmente i nomi con _ sono da cambiare), direi con energia1 (iniziato ma interrotto perchè scrivendo i pb primali componente per componente non ci tornavano cose)
* __case1_non_linear2.edp__: modifica problema case1 con modello non lineare ottenuto tramite paper Sigmund e KS (modello nostro), con energia4

__Progressi__:
* Abbiamo preso il problema linear di trazione di Micheletti (tensile.edp) e provato a mettere le BC di Nicola (__tensile_BC.edp__) e a calcolare nu con la formula di Sigmund anziché con convect (__tensile_nu.edp__) anche congiuntamente (__tensile_BC_nu.edp__)
* Abbiamo abbandonato le BC di Nicola e mantenuto il nostro calcolo di nu con la formula di Sigmund anziché convect (__tensile_nu.edp__)
* Il problema lineare di trazione di Micheletti con il nostro nu sembra funzionare sempre, nu viene 0.3 indipendentemente dallo spostamento imposto u0
* Abbiamo studiato il codice del problema non lineare dalla documentazione di FreeFemm (__ff_non_linear.edp__), correggendo il bug segnalato da Michelletti e impostando f funzione dell'energia F2 a f(F2) = F2, perché non ci interessa studiare una particolare funzione dell'energia
* La correzione del bug insieme a f come sopra funziona, se invece correggiamo il bug ma lasciando f(F2) = 0.25 * F2^2 non funziona più
* Abbiamo provato a risolvere con il codice non lineare lo stesso problema di trazione di Micheletti (__tensile_non_linear.edp__)
* Con il parametro nl = {0: lineare, 1: non lineare} davanti alla componente non lineare di epsilon abbiamo verificato che nu torna 0.3 anche con il codice non lineare, quindi è consistente con la soluzione di Micheletti, mentre nel problema non lineare viene nu = 0.68 che teniamo come riferimento per testare il problema primale non lineare ricavato da noi
* Stiamo a verificare il nostro problema primale con il non lineare di FreeFem (__tensile_non_linear_e1.edp__ e __tensile_non_linear_e4.edp__) (deve tornare nu = 0.68 facendo la stessa prova di trazione) ma siamo bloccato per un problema di 1.0 + dx(u1) in una macro, sembra errore di somma tra oggetti diversi

__nu__:

```cpp
int main() {
  real d1 = int1d(Th,2)(rho*u1) - int1d(Th,4)(rho*u1);
  real d2 = int1d(Th,3)(rho*u2) - int1d(Th,1)(rho*u2);;
  real nu12 = -d2/d1;
}
```

__BCs di Nicola__:

* __B__: Neumann omogeneo
* __D__: trazione = Dirichlet u = [u0 , 0]  -> v = int1d(bordo di sopra) (u)/ lunghezza_bordo di sopra (per convertire valore nodale in un valore singolo sul bordo di sopra)
* __T__: Neumann omogeneo
* __L__: simmetria u.n = 0

Noi stiamo lasciando lo spostamento verticale libero a DX

## Linear 3D
* __linear_3D.edp__
