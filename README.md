# neumann
*(more technical README in the future)*

Neumann is a functionality-packed boardgame rental system built in Ruby on Rails.
Its main goal is to facilitate the management of rentals and flow of game copies around
local community (broad friend group, gameshops, faculties etc.).

In order to use the system, please log in or create an account. You will then need to submit
a returnable deposit of 100 PLN to the system keepers (such as student council) to activate your account.

Having done that, you have plenty of options:

- **Add your own game copies** - want to support the community?
  Make your own copy accessible for rentals by visiting
  a game in Games and submitting it via *new copy*.
- **Review games** - leave remarks and helpful notes for other
  users about games you've already played.
- **Rent boardgames!** - find games you want to play
  and submit a rental request. You can offer something in return
  to make a request more attractive.
- **Organize meetups** - if you want to play with the community, you can
  plan a meeting that other users can join. Information about it will be
  visible in the Meetings section.

## Rental process

It's crucial to understand how rental process works in the system.
Below is a step by step description.

1. Create new rental request via button in the navigation bar or in the page of any game.
   The request is now *open*. You can go to the Games section and select games that you want to rent,
   and the ones you offer in exchange.
2. When you establish your want/offer lists, you can *submit* your request.
   Other users now see it and can accept it if they possess copies of games you've selected as wanted.
   Keep in mind that when the request is *submitted*, you can't edit its content (thankfully, you can re-open
   it).
3. You will be prompted, when someone accepts your request. It then becomes a *rental*.
4. When you confirm this matching back, you both will have an option to order a game swap.
   After doing so, the system takes appropriate game copies from your and your partner's inventories and
   swaps them between you. Rental is now *swapped*.
5. When agreed rental time passes, an option to swap games back will appear. When you click it,
   related game copies will return back to their owners and the rental will be marked as *finished*.

After finishing the rental, we kindly ask you to review your
partner and his game copies. This will make the system community a more transparent space.
