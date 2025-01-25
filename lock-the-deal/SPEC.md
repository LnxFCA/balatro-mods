# lock-the-deal

The mod must:

- LTD button

The button must be dynamic.
The button must be removed from cards when they are purchased
The button must alignment must be updated if the "Buy and Use" button
is visible.
The button text and color must change if according to its state
The button must be shown only when the card is higlighted
The must be aligned correctly if card is consumeable

- LTD button popup

Show a dynamic popup with the current lock price
Change the popup price to "Free / $0" when the current item is locked
Price is dynamic title is not
Every valid card must shop the popup when LTD button is hovered


- LTD lock table

A card can be locked twice
A card must have a unique way of identity on the lock table (id)
A locked card must be checked with its id not its key
Work on lists, don't use normal set
The lock table must be save when stage is not shop or if the
reroll_shop action is called.


- MOD spec

The mod allows the user to lock certain shop items.
It allow to lock vouchers and cards.

Criteria:

- The lock will have a cost which is calculated as 1*(n+1), where n is the number of current locked items

- The same item (the locked item, not a similar card) can be locked and unlocked without cost after the first
lock

- The lock list must support state saving, the game has various save states, in the shop, the state, is
generally not saved, it's only saved when specific stages are met, e.g. NEW_RUN, OPEN_PACK,
in those cases the locked list must be updated.

- A card of the same kind (with the same key) can be locked more than one thing, for that reason
there must be aunique way of identifying the object, for that UUID v4 will be used, the ID
needs to be assigned accordingly, so that cards are distinguished correctly.

Button Criteria:

- The button must be dynamic, when card is locked and when not, its label must change, and so its colour

- When hovered, a popup will appear, this popup will contain the current lock price for the card

- When the card is first locked, the price for that specific item will be "Free / $0", since a item can
be unlocked and re-locked for free after it is first locked, button must be behave according


## How the mod will work?.

When the shop starts, and shop cards and items are being requests, the function will
check if there any locked cards on the list, if so, it will generate the locked items
as they are found in the list, and return them until there aren't no locked items left.

The shop has many areas where items go, for that reason each lock item needs a way of verying
which area they belong to, and macth the generation accordingly, for this, the `G.shop_*`
can be used.

The must also check the area, if area match and ther are locked items on that are, it must
generate and return it, if not, then it will use the default generation method.

The generated item would have a button added, which would be located at the right-middle of
item.

When the shop is ready and loaded, the next part comes.
The button will shown when the card is higlighted, also for consumeable cards
which are generally more thin, the alignment needs to be adjusted, also
if the card has the "Buy and Use" visible, then both buttons must be aligned
correctly.

When the user clicks the lock button, the button text and color change to match
the action, after that, the card is added to the lock list and the required
information will be registered.

When the user purchases the card, the locked item would be removed from the list
and would be generated the next time the shop ask for items.

The game has many states where the user can exit and continue the match, to behave accordingly
the mod must save its state, and be capable of restore it.

## LTD button

This button is injected to the card when generated, its content is dynamic,
meaning it changes when something happens, and that is when its clicked.
To do so, the button will have a local state that belongs only to him,
this state will be used to update its UI accordingly.

The button is independient of each other item, also each card with a button
is different even if they are of of the same kind.

When the button is clicked it locks the item, because many items of the same
kind can appear, there's a need to make them different, for that reason,
when the card is created, a state is added to the card object, which
contains a field that is different for every card, it also has infomation
about the area it belongs to.

When the button is clicked, it ask the state to lock the card, and pass on
the card object it belongs to and updates the button state so the action
is reflected on the UI.

When the item is purchased, the button is removed from the card.

## Item generation

When the shop asks for items, the process is customized to allow generating
locked items.

When the item is generated, through the process the shop specific UI
is added to the card (e.g. Buttons and price), in this step a ID must
be added to the card so that every generated item is different, the only
exception are locked items generated which alredy include this field.

If the id don't exist on the item, then is must be generated and assigned when the
card shop UI is being injected, in this process the local state is added to the card,
if the card is locked generated then this state should be added when the card
is created (before adding shop UI), so a check is made here to overwrite information.

The state must has the following:

- id: A UUID v4 string
- no_locked: A boolean indicating if the actual item has been never locked before.
- lock_status: A boolean indicating the actual lock status of the card, `true` for locked, `false` otherwhise.
- button: A state only useful to the button
- button.label: The current label of the button (localized), e.g. LOCKED, LOCK
- button.price: A string indicating the current price of the LOCK action for this card

The state must be also stored separatly, so that it can be updated from outside.

After all need info is injected into the card, the card is returned to the shop.

## Item lock process

When the button is clicked, it ask the state to store the card in the lock table,
and pass the card onto it, the state, will check if there aren't not items
with that id locked already, if not, then it add to the lock_list and registers
the require information.

When the item is added, then reduces the lock cost from the user's money.
And increases the lock count, also a copy of the item local state is also saved
on the lock list, which will be restored when the item is generated.

It alsos the the `no_locked` to false, meaning that the card hasbeen
aready locked, so from now on the same shop, the card lock/unlock will be free.

The button also needs to update the button label in the local state.
Then it ask for an update on the price.

## Balance

The cost, will be increased per locked item, mean while users can lock and unlock
the same item for free once its locked once, to prevent users abusing this to
reduce the cost of the lock, the lock price will not be increased until the current
item is purchased or the following happens:

For vouchers:

- The price will reduce only when the voucher is purchased, or only when
the current ante ends and the voucher is replaced with a new one.

For cards:

- The price will reduce only when the card is purchased or the item
is unlocked and the shop is rerolled.

So the price must handle these use cases.


## Lock save

Because of how the game handle saves and how it restores its, the mod must handle the
saves specially, and only saving when indicated, also it should be able to restore
to a previous state.

A save means that when the user lefts the match and comes back, the state is restored accordingly.
The following are the special knowed cases:

- When leaving the shop: When the user leaves the shop, the game saves the run progress, so
when the user continues a run, the game restored from the point after levaing the shop,
meaning the blind select stage.

- When opening a pack: When the user opens a pack, the run state is saved, so when a player
continues a previous round, the state returns exactly to after opening the pack.

- When purchasing a voucher?

## Important

When the user don't have enough money for the lock, the button must be disabled,
this must be checked constanly because the user can sell cards.

Also, when the card has been locked before, this souldn't impide the user
for blocking, unlocking the card.

For ease of things, when the card is locked, the local state index must be updated
to hold the actual card index on the area.

The card generator function is not called when the user exists on shop stage,
but the UI shop card creation is.

## Notes

Game:update_shop is called when the shop is generated/updated,
here `load_shop_jokers` would contain a table with the required cards to be loaded
we can inject a mark here in order to make it easy for us to restore the state.

Note that `load_shop_jokers` its just a simple table, not metatable or so.
When loading it will cards CardArea:load() and pass the are table.

Inside :load it generates a base card, and then calls `card:load` to perform
card loading.

Note that the saved card is just used for storage state.

We can currently apply the mard in `card:save` and `card:load`, to mark the card
here and save the current ID of the card, so that we can restore the state later.


Save in STATE 5 and STATE 7, also on STATE 7 saving, the local state must be cleared.
