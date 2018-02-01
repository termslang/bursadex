BURSA TRADING MANUAL



TO SELL ERC20 TOKENS ON BURSA:

1. Approve your ERC20 tokens.   DO NOT TRANSFER TOKENS TO BURSA!
   Just execute approve() method on contract of the token you want to trade.
   You can check the tradable amount of a token by calling
   balanceApprovedForToken() method on BURSA contract.

2. There are two ways to sell tokens on BURSA:
2.1. Place sell order on BURSA  (FREE, 40-90000 gas)

     1) Call     willsellFindSpot(token), token address as argument.
     2) Use returned value "spot" in the next call.

     3) Execute  willsell(amount, token, price_each, spot):
        amount   - amount of tokens to buy (+ the token's decimals!);
         token   - token address;
    price_each   - price for one token, followed by 18 zeroes;
          spot   - the place in storage to save our order, returned
                 from the previous call.

     4) Wait until someone fills your order! "Sold" event will be fired.


2.2. Fill existing sell order  (0.0001 ether FEE, 40-90000 gas)    
                                1st TRADE FOR FREE!

    1) Call      findBestSell(token, min_trade_amount), where:
         token   - token address;
min_trade_amount - (optional) minimum order amount (in wei).
       Returns:
         order   - order id, use it in the next call
        volume   - maximum amount of tokens this order can buy
         price

    2) Use returned "order" and "price" in the next call.

    3) Execute   sell(amount, token, min_price_each, order, frontend_refund):
        amount   - amount of tokens to buy (+ the token's decimals!);
         token   - token address;
max_price_each   - (optional, recommended) price for one token, "price" from the previous call;
         order   - the order index returned from the previous call;
frontend_refund  - (optional) can be used by frontend developers.


TO BUY ERC20 TOKENS ON BURSA:

1. There are few ways to deposit ether to BURSA contract.
  1) Sending it to the contract;
  2) Calling deposit() method;
  3) Adding value to willbuy() or buy() method.

2. There are two ways to buy tokens on BURSA:
2.1. Place buy order on BURSA  (FREE, 40-90000 gas)

     1) Call     willbuyFindSpot(token), token address as argument.
     2) Use returned value "spot" in the next call.

     3) Execute  willbuy(amount, token, price_each, spot):
        amount   - amount of tokens to buy (+ the token's decimals!);
         token   - token address;
    price_each   - price for one token, followed by 18 zeroes;
          spot   - the place in storage to save our order, returned
                 from the previous call.

     4) Wait until someone fills your order! "Sold" event will be fired.


2.2. Fill existing buy order  (0.0001 ether FEE, 40-90000 gas)    
                                1st TRADE FOR FREE!

    1) Call      findBestBuy(token, min_trade_amount), where:
         token   - token address;
min_trade_amount - (optional) minimum order amount (in wei).
       Returns:
         order   - order id, use it in the next call
        volume   - maximum amount of tokens this order can buy
         price

    2) Use returned "order" and "price" in the next call.

    3) Execute   buy(amount, token, min_price_each, order, frontend_refund):
        amount   - amount of tokens to buy (+ the token's decimals!);
         token   - token address;
min_price_each   - (optional, recommended) price for one token, "price" from the previous call;
         order   - the order index returned from the previous call;
frontend_refund  - (optional) can be used by frontend developers.



HANDLE YOUR TRADING ACCOUNT:
Withdraw your money using withdraw() method.




FEES:
Placing orders is free on BURSA.  Using methods buy() or sell() is free
for any address for the 1st time. Trading amounts < 0.001 ether is free.
BURSA has fixed fee of 0.0001 ether for trading amounts over 0.001 ether
                                            (except for the first trade)
One can refund 0.0003 ether to frontend_refund address in buy() and sell() methods.
