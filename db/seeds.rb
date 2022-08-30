# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"


User.destroy_all
Game_match.destroy_all


def user_photo (instance, url, filename)
  file = URI.open(url)
  instance.photo.attach(io: file, filename:, content_type: "image/png")
  instance.save
end




# USERS



bobby = User.new(first_name: "Bobby",
                random_nickname: "GrosSaucisson",
                email: "bobby.levrai@gmail.com",
                password: "jaimeleswagons",
                score: 35,
                social_media: "Facebook : BobbyTV Levrai || Instagram : super_bobby")

attach_photo(bobby, "https://images.unsplash.com/photo-1614252369475-531eba835eb1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFuJTIwbW9kZWx8ZW58MHx8MHx8&w=1000&q=80", "bobby")

hector = User.new(first_name: "Hector",
                  random_nickname: "TrépeuSportif",
                  email: "hector.mail@hotmail.com",
                  password: "hectorbg59",
                  score: 7,
                  social_media: "Facebook : Hector Danatol / Insta: hector_dan")

attach_photo(hector, "https://wallpaperaccess.com/full/1448056.jpg", "hector")

julie = User.new(first_name: "Julie",
                random_nickname: "TomateFragile",
                email: "julie@gmail.com",
                password: "password",
                score: 0,
                social_media: "Facebook : Julie Laffon, Instagram : super_julie, Snap : Juju38933")

attach_photo(julie, "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmVtYWxlJTIwcG9ydHJhaXR8ZW58MHx8MHx8&w=1000&q=80", "julie")

bill = User.new(first_name: "Bill",
                random_nickname: "PetitCactus",
                email: "bill123@gmail.com",
                password: "secret",
                score: 28,
                social_media: "Facebook : Bill Jobs // Instagram : @bill_jobs")

attach_photo(bill, "https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8eW91bmclMjBtZW58ZW58MHx8MHx8&w=1000&q=80", "bill")

mathilde = User.new(first_name: "Mathilde",
                    random_nickname: "PasuperCalme",
                    email: "mathildedu39@hotmail.com",
                    password: "petiteprincesse",
                    score: 31,
                    social_media: "Tel : 06998878 - Facebook : Mathou Rgx - Instagram : @math_rgx")

attach_photo(mathilde, "https://i.pinimg.com/originals/39/8b/fa/398bfa54c82f4f5143808e8fa6b75234.png", "mathilde")

daniel = User.new(first_name: "Daniel",
                random_nickname: "PlanteSauvage",
                email: "daniellegrand@gmail.com",
                password: "cestunmotdepasse",
                score: 3,
                social_media: "Numéro perso : 0636789076")

attach_photo(daniel, "https://images.unsplash.com/photo-1522529599102-193c0d76b5b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBtYW58ZW58MHx8MHx8&w=1000&q=80", "daniel")

alfred = User.new(first_name: "Alfred",
                  random_nickname: "BoudeurContent",
                  email: "alfredolagrange@hotmail.com",
                  password: "alfredolagrange",
                  score: 31,
                  social_media: "Alfred Lagrange (sur Facebook et Insta)")

attach_photo(alfred, "https://media.istockphoto.com/photos/shot-of-a-handsome-young-man-standing-against-a-grey-background-picture-id1335941248?b=1&k=20&m=1335941248&s=170667a&w=0&h=sn_An6VRQBtK3BuHnG1w9UmhTzwTqM3xLnKcqLW-mzw=", "alfred")

benoit = User.new(first_name: "Benoit",
                random_nickname: "SuperTravailleur",
                email: "bladoucette@gmail.com",
                password: "monmotdepasse",
                score: 42,
                social_media: "Facebook => benoit Ladoucette")

attach_photo(benoit, "https://images.unsplash.com/photo-1584043720379-b56cd9199c94?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fG1lbnxlbnwwfHwwfHw%3D&w=1000&q=80", "benoit")

marguerite = User.new(first_name: "Marguerite",
                  random_nickname: "ApprentieDictatrice",
                  email: "paquerettdesigneuse@sfr.fr",
                  password: "cassoulet12345",
                  score: 1,
                  social_media: "Tel : 06388001 - Facebook : Marg Paquerett - Instagram : Paqu_rette - Github : Paquerett - Snap : tropbgettedu44 - TikTok : Paqou - LinkedIn : Margueritte Paquerette")

attach_photo(marguerite, "https://images.unsplash.com/photo-1557053910-d9eadeed1c58?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d29tYW4lMjBwb3J0cmFpdHxlbnwwfHwwfHw%3D&w=1000&q=80", "marguerite")


jean = User.new(first_name: "Jean",
                random_nickname: "DouceCracotte",
                email: "jeanavocat123@gmail.com",
                password: "secretpassword",
                score: 13,
                social_media: "Insta : Jean Avocatt, numéro : 0695679085")

attach_photo(jean, "https://img.freepik.com/photos-premium/garcon-adolescent-hispanique-mains-oreilles-souffrant-maux-oreilles-isoles-fond-bleu_221194-1663.jpg", "jean")





# SESSIONS




session1 = Trip_session.create(status: "closed",
                    creator_id: bill.id,
                    joiner_id: mathilde.id)

session2 = Trip_session.create(status: "closed",
                    creator_id: bill.id,
                    joiner_id: hector.id)

session3 = Trip_session.create(status: "closed",
                    creator_id: hector.id,
                    joiner_id: mathilde.id)

session4 = Trip_session.create(status: "in game",
                    creator_id: hector.id,
                    joiner_id: mathilde.id)

session5 = Trip_session.create(status: "in game",
                    creator_id: julie.id,
                    joiner_id: bill.id)

session6 = Trip_session.create(status: "in game",
                    creator_id: bobby.id,
                    joiner_id: daniel.id)

session7 = Trip_session.create(status: "in game",
                    creator_id: alfred.id,
                    joiner_id: benoit.id)

session8 = Trip_session.create(status: "waiting for joiner",
                    creator_id: marguerite.id)




# SESSION 1


play1session1 = Tic_tac_toe_game.create(position_1:"cross",
                        position_2:"circle",
                        position_4:"cross",
                        position_7:"cross",
                        position_8:"circle",
                        cross_player_id: session1.creator_id,
                        circle_player_id: session1.joiner_id)


gamematch1session1 = Game_match.create(winner:bill.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session1,
                      session_id: session1.id)

gamematch2session1 = Game_match.create(winner:bill.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id:play1session1,
                      session_id:session1.id)


Message.create(content: "Holaaaa",
                      session_id: session1.id,
                      user_id: session1.creator_id)

request = Request.create(status:"Pending",
                      sender_id:session1.creator_id,
                      session_id:session1.id)

Message.create(content: "T'as vu le bus ? Trop bizarre, pourquoi il s'est arrêté ?",
                      session_id: session1.id,
                      user_id: session1.joiner_id)

Message.create(content: "Aucune idée ahah, au moins je peux te battre une nouvelle fois",
                      session_id: session1.id,
                      user_id: session1.creator_id)

request.status = "Refused"

Message.create(content: "Je dois filer",
              session_id: session1.id,
              user_id: session1.creator_id)



# SESSION 2

play1session2 = Tic_tac_toe_game.create(position_1:"circle",
                        position_2:"circle",
                        position_3:"circle",
                        position_5:"cross",
                        position_6:"cross",
                        position_7:"cross",
                        position_9:"cross",
                        cross_player_id: session2.creator_id,
                        circle_player_id: session2.joiner_id)

gamematch1session2 = Game_match.create(winner:hector.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session2,
                      session_id: session2.id)



# SESSION 3

play1session3 = Tic_tac_toe_game.create(position_1:"cross",
                        position_2:"cross",
                        position_3:"circle",
                        position_6:"circle",
                        position_7:"cross",
                        position_8:"cross",
                        position_9:"circle",
                        cross_player_id: session3.creator_id,
                        circle_player_id: session3.joiner_id)

gamematch1session3 = Game_match.create(winner:mathilde.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session3,
                      session_id: session3.id)


Message.create(content: "Gogogooo",
                      session_id: session3.id,
                      user_id: session3.joigner_id)

Message.create(content: "On fait juste une partie, si tu gagnes on fait la belle!",
                      session_id: session3.id,
                      user_id: session3.creator_id)

Message.create(content: "Oh nooon je vais perdre là!",
                      session_id: session3.id,
                      user_id: session3.creator_id)

request = Request.create(status:"Pending",
                      sender_id:session3.creator_id,
                      session_id:session3.id)

Message.create(content: "Revanche du coup ?",
                      session_id: session3.id,
                      user_id: session3.creator_id)

Message.create(content: "Désolé je dois filer:)",
                      session_id: session3.id,
                      user_id: session3.joigner_id)

request.status = "Accepted"




# SESSION 4

play1session4 = Tic_tac_toe_game.create(position_1:"cross",
                        position_8:"cross",
                        position_9:"circle",
                        cross_player_id: session4.creator_id,
                        circle_player_id: session4.joiner_id)

gamematch1session4 = Game_match.create(winner:mathilde.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session4,
                      session_id: session4.id)

gamematch2session4 = Game_match.create(winner:hector.id,
                    matchable_type:"Tic_tac_toe_game",
                    matchable_id: play1session4,
                    session_id: session4.id)

gamematch3session4 = Game_match.create(winner:mathilde.id,
                    matchable_type:"Tic_tac_toe_game",
                    matchable_id: play1session4,
                    session_id: session4.id)

gamematch4session4 = Game_match.create(winner:mathilde.id,
                  matchable_type:"Tic_tac_toe_game",
                  matchable_id: play1session4,
                  session_id: session4.id)

gamematch5session4 = Game_match.create(matchable_type:"Tic_tac_toe_game",
                  matchable_id: play1session4,
                  session_id: session4.id)



Message.create(content: "Hello ! Prêt à en découdre ?",
                  session_id: session4.id,
                  user_id: session4.creator_id)

Message.create(content: "T'as l'air chaud !!",
                  session_id: session4.id,
                  user_id: session4.joiner_id)

Message.create(content: "Ahah oui, je prends ce bus tous les jours depuis 4 mois",
                  session_id: session4.id,
                  user_id: session4.creator_id)

Message.create(content: "Moi aussi !",
                  session_id: session4.id,
                  user_id: session4.joiner_id)

Message.create(content: "On essai de se retrouver ? Je descends à Trois Suisses",
                  session_id: session4.id,
                  user_id: session4.creator_id)

Message.create(content: "Je descends à la prochaine mais on peut se retrouver ce soir. Je t'envoie une demande:)",
                  session_id: session4.id,
                  user_id: session4.joiner_id)


Request.create(status:"Pending",
              sender_id:session4.joigner_id,
              session_id:session4.id)





# SESSION 5

play1session5 = Tic_tac_toe_game.create(position_6:"cross",
                        position_9:"circle",
                        cross_player_id: session5.creator_id,
                        circle_player_id: session5.joiner_id)

gamematch1session5 = Game_match.create(matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session5,
                      session_id: session5.id)



# SESSION 6

play1session6 = Tic_tac_toe_game.create(position_1:"cross",
                        position_5:"circle",
                        position_6:"cross",
                        position_7:"cross",
                        position_8:"circle",
                        position_9:"circle",
                        cross_player_id: session6.creator_id,
                        circle_player_id: session6.joiner_id)

gamematch1session6 = Game_match.create(winner:bobby.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session6,
                      session_id: session6.id)

gamematch2session6 = Game_match.create(matchable_type:"Tic_tac_toe_game",
                  matchable_id: play1session6,
                  session_id: session6.id)


Message.create(content: "Bien joué pour ta victoire",
                  session_id: session6.id,
                  user_id: session6.joigner_id)

Message.create(content: "Et le trajet n'est même pas fini",
                  session_id: session6.id,
                  user_id: session6.creator_id)

Message.create(content: "Attends de voir ma botte secrète:)",
                  session_id: session6.id,
                  user_id: session6.creator_id)

Message.create(content: "Oulaaa t'as pris la confiance ahah",
                  session_id: session6.id,
                  user_id: session6.joiner_id)

Message.create(content: "Je suis pas comme ça dans la vraie vie, promis hehe",
                  session_id: session6.id,
                  user_id: session6.creator_id)

Message.create(content: "ça mérite vérifications!",
                  session_id: session6.id,
                  user_id: session6.joiner_id)


request = Request.create(status:"Pending",
              sender_id:session6.joigner_id,
              session_id:session6.id)

Message.create(content: "N'oublie pas de jouer quand même",
              session_id: session6.id,
              user_id: session6.creator_id)

request.status = "Accepted"

Message.create(content: "Aaah bonjour Daniel:) Top photo",
              session_id: session6.id,
              user_id: session6.creator_id)




# SESSION 7

play1session7 = Tic_tac_toe_game.create(cross_player_id: session7.creator_id,
                        circle_player_id: session7.joiner_id)

gamematch1session7 = Game_match.create(winner:alfred.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session7,
                      session_id: session7.id)

gamematch2session7 = Game_match.create(winner:benoit.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session7,
                      session_id: session7.id)

gamematch3session7 = Game_match.create(winner:alfred.id,
                      matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session7,
                      session_id: session7.id)

gamematch4session7 = Game_match.create(matchable_type:"Tic_tac_toe_game",
                  matchable_id: play1session7,
                  session_id: session7.id)


Message.create(content: "Pas mal, tu joue souvent ?",
                  session_id: session7.id,
                  user_id: session7.joigner_id)

Message.create(content: "Oui, c'est ma ligne de métro quotidienne ahah",
                  session_id: session7.id,
                  user_id: session7.creator_id)

Message.create(content: "ok",
                  session_id: session7.id,
                  user_id: session7.creator_id)

request = Request.create(status:"Pending",
              sender_id:session7.creator_id,
              session_id:session7.id)

Message.create(content: "Je préfère rester anonyme, sorry",
              session_id: session7.id,
              user_id: session7.joigner_id)

request.status = "Refused"

Message.create(content: "okok dommage",
              session_id: session7.id,
              user_id: session7.creator_id)



# SESSION 8

play1session8 = Tic_tac_toe_game.create(cross_player_id: session8.creator_id)

gamematch1session8 = Game_match.create(matchable_type:"Tic_tac_toe_game",
                      matchable_id: play1session8,
                      session_id: session8.id)








# SCHEMA :

# Tic_tac_toe_game.create(position_1:,
#                         position_2:,
#                         position_3:,
#                         position_4:,
#                         position_5:,
#                         position_6:,
#                         position_7:,
#                         position_8:,
#                         position_9:,
#                         cross_player_id:,
#                         circle_player_id:)

# Game_match.create(winner:,
#                   matchable_type:,
#                   matchable_id:,
#                   session_id:)

# Message.create(content:,
#               session_id: ,
#               user_id: )

# Request.create(status:,
#               sender_id:,
#               session_id:)
