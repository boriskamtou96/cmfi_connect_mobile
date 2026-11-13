# Enseignements : l'écoute à la suite

**Demandé le 13/11/2026** : « que j'écoute en continu, que les écoutes se suivent, que je n'aie pas à appuyer moi-même pour passer à la suite ».

## Ce qui a été choisi

« La suite », c'est **la liste que le membre regarde** quand il lance un message (choix A) : ce qui est affiché sous le message, avec la recherche et les filtres du moment. Pour une édition (un camp), le serveur donne déjà l'ordre du camp : jour 1 message 1, message 2, puis jour 2. L'autre voie (B : seulement la même édition) a été écartée : A fait la même chose pour un camp (on filtre sur l'édition) et marche aussi pour un orateur ou une catégorie.

## Ce que fait le lecteur

1. **Enchaînement** : à la fin d'un message, le suivant de la liste démarre, écran verrouillé compris. Au bout de la page affichée, la suite de la liste est demandée au serveur.
2. **Précédent / suivant** : dans le lecteur, sur l'écran de verrouillage, la notification et les écouteurs. « Précédent » revient au début du message s'il est commencé depuis plus de 5 secondes.
3. **« À suivre »** : les 10 prochains messages dans le lecteur ; un toucher y va.
4. **Minuterie de sommeil** : dans 15, 30, 45 minutes ou 1 heure (pause), ou à la fin du message en cours (rien ne suit, une seule fois).
5. **« Lecture en continu »** : un interrupteur, retenu ; allumé par défaut.
6. **Sans réseau** : le message suivant qui ne s'ouvre pas laisse la place au prochain message gardé sur le téléphone ; s'il n'y en a pas, le lecteur se ferme.

## Ce qui n'est pas fait

- La file n'est pas gardée quand l'app est fermée : rouvrir l'app et relancer un message refait la file depuis la liste.
- Un message déjà « Écouté » n'est pas sauté : il rejoue depuis le début.
- Le mini lecteur n'a pas de bouton « suivant ».
- L'enchaînement se fait dans l'app (elle ouvre le message suivant), pas par une playlist confiée au système : **à vérifier sur un iPhone et un Android, écran verrouillé, sur plusieurs messages de suite**. Si un téléphone coupe entre deux messages, la suite est de donner la file à just_audio (`setAudioSources`).
