# Tutoriel Ajouter un composant Kanban dans une vue PowerApps
> Version 2025.03.28, Auteur : Dominique Delaire   
> Fonctionne sous : Dynamics 365 Sales, PowerApps Model driven
> 
![273406081-18dd8668-0cb7-4c55-b958-b5224eb72815](https://github.com/user-attachments/assets/44661529-2e29-4633-b432-ebc1ec0375de)


Dans cet exemple, nous allons créer une nouvelle table Dataverse qui servira d'activités et de tâches à une table Dataverse nommée "Entités" qui gère des contacts, entreprises, fournisseurs, ...

La table des activités servira pour suivre des tâches, évènements, activités, rdv en lien avec une "Entité".

Le module permettra de gérer ses activités sous forme de Kanban !

# Prérequis
* Avoir un compte Microsoft PowerApps et un environnement de développement pour créer une solution
* Créer une solution dans votre environnement (dans notre exemple Mylife365 mais vous pouvez mettre n'importe quel nom)
* Les vues Kanban peuvent se faire uniquement sur des tables de type "Activités" ou "Opportunités".

# Partie 1 : Eléments de base
#### Etape 1 : Dans notre solution "Mylife365" (créez la votre), nous allons ajouter une nouvelle table.

![273406168-37b3510e-7d23-4924-9744-5aeebc5c1808](https://github.com/user-attachments/assets/de4133f5-d9f5-4668-80dd-ae0c0073e3e9)


#### Etape 2 : Nommez la "Activités et tâches" et choisissez comme type "Activités".

![273406229-687a4326-3d12-40ec-a219-ceac3416e303](https://github.com/user-attachments/assets/c707dec9-0d69-4c0c-9c7b-f1a384248ce3)


#### Etape 3 : Vous pouvez cocher aussi "Apparaître dans les résultats de recherche", puis enregistrez. Laissez les champs créés automatiquement tel quel pour la démo.

![273406263-cdf45e2c-a069-485e-a8ae-054f306cae42](https://github.com/user-attachments/assets/bdb3f41e-5afc-40d5-b198-d33f2075e47f)


#### Etape 4 : Pour faire le lien entre cette nouvelle table et notre table existante de gestion de contacts et d'entreprise, il faut dans la table de gestion des contacts et d'entreprise, cocher la case "Faire de cette table une option quand : création d'une activité" 

![273406325-b1eec317-337b-4754-9486-bb050b24fac2](https://github.com/user-attachments/assets/331eab81-8d71-4d33-bce1-1b45eb66866b)


#### Etape 5 : Notre table "Activités et Tâches" est bien présente dans la liste des objets de notre solution.

![273406411-652843be-f46b-4b6c-a73f-cc87cc2e99bc](https://github.com/user-attachments/assets/1a1ce79c-39cb-457b-ba36-a557b35f1426)


#### Etape 6 : On va maintenant ajouter notre entité dans le menu de l'application.

![273406476-2f311a47-e315-4e10-9589-f4f1d03f1ce3](https://github.com/user-attachments/assets/b3c4fe4a-f561-4e66-a80d-2fc8fb42dcee)


#### Etape 7 : Il suffit de sélectionner notre table dataverse créée

![273406542-5ade3530-2d85-4111-a90f-c2cb20aeb5ec](https://github.com/user-attachments/assets/371e82b1-d119-45f9-945c-a3a88459add7)


#### Etape 8 : pour avoir notre nouvelle option dans le menu. Enregistrer et publier vos personnalisations.
![273406612-2a4f3236-c0ce-445e-9858-da0028a8801e](https://github.com/user-attachments/assets/09dd41b5-9c98-48b4-ac08-dd8663d31937)

#### Etape 9 : Ensuite, sélectionner votre application model driven dans la solution et sur le bouton droit de la souris. Sélectionner "Lire" pour lancer votre apps.

![273406660-ec177d77-e5f0-48fb-a789-c49b044ab287](https://github.com/user-attachments/assets/4ddeb10d-b320-4e93-8f5d-6cd0fac80497)


#### Etape 10 : On va tester maintenant et commencer à saisir des exemples dans notre environnement de développement pour notre nouvelle table.

![273406671-e092b3fa-df97-4dda-85fe-171853b61fb3](https://github.com/user-attachments/assets/2a36d865-753d-49a8-80c0-b5e9ec405707)


#### Etape 11 : On choisit Activités et tâches, puis dans le bandeau du haut à droite, on clique sur les ... et on sélectionne "Activités et Tâches" pour créer une nouvelle activité.

![273406674-a9e45099-e059-471b-8f9a-7984c9897c9d](https://github.com/user-attachments/assets/dcab72d5-a8bd-4597-ae07-d65f86ebd2c6)



#### Etape 12 : Saisir un Sujet et un concernant. Dans le concernant, il va pointer vers la table "Entité" contenant les contacts ou entreprises.
C'est automatique car il y a 2 tables dans notre solution PowerApps et grâce à l'étape 4 (cochez création d'une activité)

![273407041-c7664e51-2e00-493e-ae39-f5c0c5b72539](https://github.com/user-attachments/assets/9996512d-c973-4ee6-8e9a-ade97eecb6f4)



#### Etape 13 : Sélectionner un enregistrement de la table "Entité" et saisir une date d'échéance par exemple avec une heure spécifique. Puis Enregistrez et fermer.

![273407180-2383d5a6-6905-46fd-813b-a28552fb0baa](https://github.com/user-attachments/assets/7cc13525-9cc9-4071-b758-1482c1ef90c8)


#### Etape 14 : Créez un deuxième enregistrement (Etape 11) mais cette fois ci dans le "Concernant", nous allons créer un nouvel enregistrement. Pour cela, cliquez sur "Créer enregistrement", puis choisir "Entités".

![273407232-9179e5ba-3557-4be1-aa4b-6fc9ca2c0da7](https://github.com/user-attachments/assets/834522c8-21ea-4389-abeb-67666c8443f7)
![273407247-f76cf70a-69ec-45d0-a19d-29b1292dcfbb](https://github.com/user-attachments/assets/6473e702-ce71-42e2-9abc-c8bfc3e09fc3)


#### Etape 15 : Saisissez des données dans l'entité (ca peut être votre entité à vous). Puis cliquez sur "Enregistrer et fermer"

![273407370-875b7ec6-2224-4559-a58a-e23bef0f8f7d](https://github.com/user-attachments/assets/473d6f1f-2296-420e-8240-73fa4de8190a)


#### Etape 16 : Le "Concernant" a maintenant votre nouvelle donnée.

![273407426-d7b27ffe-0137-4d28-a27f-be11561975ca](https://github.com/user-attachments/assets/6dbe6016-ac13-480a-ad56-9feacdd28e7a)


#### Etape 17 : Nous avons maintenant 2 nouvelles activités et tâches. Nous voyons par défaut que la vue présente les informations sous forme de liste.
L'objectif est de les présenter sous forme de KanBan.

![273407464-c10b382c-87ca-4cd3-9b56-ab4df0ed1630](https://github.com/user-attachments/assets/342eaf23-cb27-4b68-aac2-334e2131a50e)


# Partie 2 : Définition du Kanban pour une vue spécifique
#### Etape 18 : Pour ajouter une vue Kanban sur l'ensemble des vues, il va falloir passer par l'ancienne interface. Pour cela, cliquez sur l'engrenage et choisir "Paramètres avancés".
![273407464-c10b382c-87ca-4cd3-9b56-ab4df0ed1630](https://github.com/user-attachments/assets/0c9e297b-753d-4bff-a002-f15868d62031)


#### Etape 19 : Puis dans le bandeau supérieur, choisir "Paramètres" puis l'option "Solutions". Sélectionner votre solution (la mienne ici est Mylife365)

![273407791-5b62b9f8-e347-4be6-97f6-83fb129b7395](https://github.com/user-attachments/assets/3cb85614-c6d9-4adc-9808-84b7b4f9f579)


#### Etape 20 : Double cliquer sur "Activités et Tâches" dans les entités de la solution. Puis choisir l'onglet "Contrôles". Choisir ensuite l'option "Ajouter un contrôle".

![273407860-0b4c573c-4962-430e-a7dd-9f957109dccb](https://github.com/user-attachments/assets/93c7b7a3-dd7a-427e-8152-566d7c851185)


#### Etape 21 : Sélectionner ensuite dans la liste le contrôle standard "Kanban" puis cliquer sur le bouton "Ajouter"

![273407926-f7c1654e-7d8e-4144-8ba5-070f12801599](https://github.com/user-attachments/assets/3639fad8-e862-4f5b-93d9-4a93b016a3eb)


#### Etape 22 : Nous allons activer cette interface seulement pour web et tablette. Sur le téléphone, cela serait moins ergonomique surtout pour déplacer des enregistrements de case en case :) 
Si vous activez ce contrôle sur l'entité, toutes les vues auront ce contrôle par défaut. Si vous souhaitez qu'une vue spécifique est une vue Kanban est pas les autres, allez à l'étape suivante 23.

![273408012-c3a9cf40-ed6b-4e6b-9ed9-a7444a095762](https://github.com/user-attachments/assets/004a21a5-4b9c-4a7c-9bdf-a6dcbdc9995c)


#### Etape 23 : On va faire la même chose mais au lieu de l'entité, on va choisir une vue spécifique existante pour appliquer la vue Kanban :)

![273408104-b0043509-a8f3-4e4e-9fa8-9d0e089b8e14](https://github.com/user-attachments/assets/26ff36eb-01dd-4f8b-a6bc-bbc6fe678c9f)


#### Etape 24 : On va configurer la vue par défaut "toutes les activités et tâches". Pour cela, double cliquer sur la vue pour obtenir l'écran suivant.
Cliquez ensuite dans la section "Tâches courantes" sur l'option "Contrôles personnalisés".

![273408870-88110ec2-70d4-4395-8c95-874c09ff35a7](https://github.com/user-attachments/assets/6385911e-625f-4ffa-ab4b-e2caa337f711)


#### Etape 25 : De la même façon que pour la table "Activités et tâches", ajouter le contrôle Kanban (voir étape 21)
Comme pour la table, on va juste avoir une vue Kanban en web et tablette. On n'active pas ce composant sur le mobile / téléphone.
![273408970-1dae120f-aee3-4b67-b9b5-0c483de32d1d](https://github.com/user-attachments/assets/1efed2b2-707a-478e-aed4-a04930d4a102)
![273408972-baf565b7-db20-4f6e-aa42-de70c25282bd](https://github.com/user-attachments/assets/7aba7c32-3136-4176-a859-5d749b4cb9bd)
![273409037-1fcf1abe-06fa-4dc7-ac4b-27ac1375b9a0](https://github.com/user-attachments/assets/e1b8ce81-8824-4f93-8571-d7773e8c51da)



#### Etape 26 : Une fois fais, on clique sur "Enregistrer et Fermer"

![273409067-b5487914-7fa7-40d3-9fbb-be1583ef04ab](https://github.com/user-attachments/assets/836d6fd4-0131-4674-b3de-8b3ef0886e60)


#### Etape 27 : Ne pas oublier de Publier toutes les personnalisations :)
![273409071-35f4d317-a6c9-4567-9cda-bbe0f997ec63](https://github.com/user-attachments/assets/db807341-e137-46ab-aa5d-a4faf009e909)


#### Etape 28 : Maintenant on retourne dans notre environnement de développement dans l'application. On rafraichit la page en actualisant ou en faisant F5. Maintenant lorsqu'on clique sur le menu de gauche "Activités et Tâches", notre vue Kanban s'affiche par miracle :)
![273409173-0a36d300-0321-4fd1-87bb-42874d152b9a](https://github.com/user-attachments/assets/ac3b462b-f6d3-46d4-a736-7d5ce2928d24)



#### Etape 29 : On va tester la vue. On prend l'activité "Faire tutoriel sur Kanban" et on la glisse vers la colonne "Terminé". Un écran s'affiche pour confirmer le changement de statut ! On clique sur le bouton "Fermer Activités et Tâches" et l'activité est bien déplacée.
![273409221-743c2e2f-dfa7-46c7-a311-d2ede54fcfa7](https://github.com/user-attachments/assets/8e6b8368-369f-4ba9-bdd3-91475f52872a)



#### Etape 30 : On peut filtrer après sur ce que l'on veut comme la date d'échéance. Ici j'affiche les activités à venir des 7 prochains jours.
On peut ajuster certains éléments du Kanban lorsque nous sommes dans la définition de la vue au niveau du contrôle.



> Comme d'habitude, Si vous avez des questions ou un projet, vous pouvez me contacter sur [Linkedin](https://www.linkedin.com/in/dominiquedelaire/)
> Notre équipe sénior d'une vingtaine de consultants est là pour vous aider !
> Dominique
