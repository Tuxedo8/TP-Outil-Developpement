# TP-Outil-Developpement
***NOTE DE L'AUTEUR (Saphir Gobbi): Les fichiers run.sh, valgrind_report.sh, strip.sh et perf_compil.sh ont été modifié afin de complété l'activité.***

# Sujet de l'activité
Pour cette activité, vous aurez à écrire un ensemble de scripts bash
destinés à servir de petits utilitaires lors d'une activité de développement.
Dans aucun des exercices il ne vous est demandé d'écrire un Makefile, si
vous devez utiliser make vous pouvez supposer que le Makefile est déjà
écrit ou que les règles implicites suffisent.

## 1. Compilation et exécution
Dans cette partie, il vous est demandé d'écrire un script nommé run.sh
qui, pour chaque argument x qui lui est donné sur la ligne de commande,
devra :
- compiler x grâce à make si x possède une extension : dans ce cas x
est de la forme base.extension, et make devra être utilisé pour
produire l'exécutable de nom base. Si la compilation échoue, le
script devra se terminer avec le code de retour 1 ;
- exécuter x (si x n'a pas d'extension) ou base (si x a une extension).
Pour cet exercice, vous ne devez produire aucun affichage sur la sortie
standard autre que ceux correspondants au travail demandé.

## 2. Comparaison de performance
Dans cette partie, vous devez écrire un script nommé perf_compil.sh qui,
étant donné un programme x dont le nom est fourni en premier argument,
devra :
1. compiler x en utilisant clang :
    - directement, en respectant la variable d'environnement CFLAGS, si x contient l'extension .c ;
    - avec make, en supposant que les variables d'environnement CC et CFLAGS sont prises en compte, sinon.
2. exécuter l'exécutable résultant :
    - avec pour arguments, tous les arguments restants (ceux
donnés au script après le premier) ;
    - en stockant son temps d'exécution.
3. recommencer les points 1 et 2 avec gcc
4. selon l'exécution la plus rapide, afficher l'un des messages suivants :
    - clang est meilleur que gcc ;
    - gcc est meilleur que clang ;
    - clang et gcc sont similaires.
Ce script devra se terminer avec le code de retour 0 (si tout se passe bien) ou :
    - 1 si on ne lui donne aucun argument ;
    - 2 si l'une des compilations échoue.
Pour cet exercice, vous ne devez produire aucun affichage autre que ceux correspondants au travail demandé (et dans l'ordre
demandé) sur la sortie standard.

## 3. Rapport valgrind
Il vous faut maintenant écrire un script nommé valgrind_report.sh qui exécute à l'aide de valgrind le programme dont le nom est
donné en premier argument en lui fournissant comme arguments tous les arguments restants (après le premier). Ce script devra
capturer les sorties de valgrind afin de les réafficher sur la sortie d'erreur standard sous la forme simplifiée suivante :

- Les erreurs de lecture devront être indiquées sur une ligne sous la forme : <br>
``Erreur en lecture dans <fonction> (<fichier>:<ligne>)`` <br>
- Les erreurs d'écriture devront être indiquées sur une ligne sous la forme : <br>
``Erreur en ecriture dans <fonction> (<fichier>:<ligne>)`` <br>
- Les fuites mémoire devront être comptabilisées en faisant la somme des fuites definitives, indirectes, possibles, ainsi que des
zones encore atteignables et supprimées. Le total devra être affiché sous la forme : <br>
``Total des fuites : <nombre> octets`` <br>

A titre d'exemple, l'utilisation de ce script sur ex_tableau_erreur donne la sortie d'erreur : <br>
``Erreur en ecriture dans main (ex_tableau_erreur.c:17)
Total des fuites : 480 octets`` <br>

La localisation utilisée pour chaque erreur correspond à la source de l'erreur (première localisation indiquée par valgrind), pas à la
localisation de l'allocation correspondante.
Pour cet exercice, vous pouvez supposer que l'exécutable fourni est compilé avec -g et vous ne devez produire aucun affichage autre
que ceux correspondants au travail demandé sur la sortie d'erreur.

## 4. Nettoyage
Pour terminer, écrivez un script, strip.sh, qui, pour chaque argument x qui lui est donné :
- si x est un répertoire, applique le traitement effectué par le script à tout les fichiers (non cachés) contenus dans x ;
- sinon :
    - si x est un fichier au format ELF (la commande file peut vous aider), lui applique la commande strip ;
    - sinon, le supprime.

## Script de test
Pour tester vos script, vous aurez à votre disposition les programmes en C suivant : 
- *code_faux.c*
- *ex_tableau_erreur.c*
- *fibonacci.c*
