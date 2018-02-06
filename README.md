

# BURSA TRADING MANUAL
---
### TO SELL ERC20 TOKENS ON BURSA:

#### 1. Approve your ERC20 tokens.
**DO NOT TRANSFER TOKENS TO BURSA!** Just execute **approve()** method on contract of the token you want to trade. You can check the tradable amount of a token by calling **balanceApprovedForToken()** method on BURSA contract.

**NOTE:** The amounts of tokens are represented the way they are stored on the blockchain. That means, if you have 10 tokens, and the token has 18 decimals, the amount of tokens stored will be 10 + 1e18 = 10000000000000000000 (10 + 18 zeroes appended). Prices are always stored with 18 decimals, regardless token's decimals.


#### 2. There are two ways to sell tokens on BURSA:
---
### 2.1. Place sell order on BURSA  (FREE)
1. Call     **willsellFindSpot(token)**, token address as argument.
2. Use returned value **spot** in the next call.
3. Execute  **willsell(amount, token, price_each, spot)**:
     * **amount**   - amount of tokens to buy
     * **token**   - token address
     * **price_each**   - price for one token, followed by 18 zeroes
     * **spot**   - the place in storage to save our order, returned from the previous call
4. Wait until someone fills your order! **Trade** event will be fired.
---
### 2.2. Fill existing sell order (0.0001 ether fee, 1st TRADE FOR FREE)

1. Call **findBestBid(token, min_trade_amount)**:
Arguments:
    *  **token**   - token address
    *  **min\_trade\_amount** - (optional) minimum order amount (in wei)

    Returns:
    * **order** - order id, use it in the next call
    * **volume**   - maximum amount of tokens this order can buy
    * **price** - price of one token
2. Use returned **order** and **price** in the next call.
3. Execute **sell(amount, token, min_price_each, order, frontend_refund)**:
    * **amount**   - amount of tokens to buy
    * **token**   - token address
    * **max\_price\_each**   - (optional, recommended) price for one token
    * **price** from the previous call
    * **order**   - the order index returned from the previous call
    * **frontend\_refund**  - (optional) can be used by frontend developers
---

### TO BUY ERC20 TOKENS ON BURSA:

#### 1. There are few ways to deposit ether to BURSA contract.
 * Sending it to the contract;
 * Calling **deposit()** method;
 * Adding value to **willbuy()** or **buy()** method.

#### 2. There are two ways to buy tokens on BURSA:
---
### 2.1. Place buy order on BURSA  (FREE)
1. Call     **willbuyFindSpot(token)**, token address as argument.
2. Use returned value **spot** in the next call.
3. Execute  **willbuy(amount, token, price_each, spot)**:
     * **amount**   - amount of tokens to buy
     * **token**   - token address
     * **price_each**   - price for one token, followed by 18 zeroes
     * **spot**   - the place in storage to save our order, returned
                 from the previous call

4. Wait until someone fills your order! **Trade** event will be fired.
---
### 2.2. Fill existing buy order  (0.0001 ether FEE, 1st TRADE FOR FREE!)
1. Call **findBestAsk(token, min_trade_amount)**.

    Arguments:
    * **token**   - token address
    * **min_trade_amount** - (optional) minimum order amount (in wei)

    Returns:
    * **order**   - order id, use it in the next call
    * **volume**   - maximum amount of tokens this order can buy
    *  **price**
2. Use returned **order** and **price** in the next call.

3. Execute **buy(amount, token, min_price_each, order, frontend_refund)**:
    * **amount**   - amount of tokens to buy
    * **token**   - token address
    * **min_price_each**   - (optional, recommended) price for one token, **price** from the previous call
    * **order**   - the order index returned from the previous call
    * **frontend_refund**  - (optional) can be used by frontend developers

---

### HANDLE YOUR TRADING ACCOUNT:
Withdraw your money using **withdraw()** method.

### CANCELLING YOUR ORDER:
You can always cancel your own order by executing it from the address it was placed. It's free and costs little gas. Uncovered orders may be cancelled automatically in the process of trading.

---



### FEES:
Placing orders is free on BURSA.  Using methods **buy()** or **sell()** is free for any address for the 1st time. Trading amounts < 0.001 ether is free. BURSA has fixed fee of 0.0001 ether for trading amounts over 0.001 ether (except for the first trade). One can refund 0.0003 ether to **frontend_refund address** in **buy()** and **sell()** methods.

---

**[BURSA on Ethereum mainnet](https://etherscan.io/address/0xd3e64580cb5b4d079514dcf2996dea6095a57e30#readContract)**

**[BURSA on ropsten](https://ropsten.etherscan.io/address/0xC9d78ebd4D11d0Dd6FE16953EfE6534A2cc0A9c7)**
### BURSA abi:
```js
[{"constant":false,"inputs":[{"name":"amount","type":"uint256"},{"name":"token","type":"address"},{"name":"price_each","type":"uint256"},{"name":"bid_order_spot","type":"uint256"}],"name":"willbuy","outputs":[{"name":"","type":"bool"}],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[],"name":"updateAvailable","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"token","type":"address"},{"name":"min_trade_amount","type":"uint256"}],"name":"findBestBid","outputs":[{"name":"bid_order","type":"uint256"},{"name":"volume","type":"uint256"},{"name":"price","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"amount","type":"uint256"}],"name":"withdraw","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"token","type":"address"},{"name":"user","type":"address"}],"name":"balanceApprovedForToken","outputs":[{"name":"amount","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"user","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"token","type":"address"},{"name":"ask_order","type":"uint256"}],"name":"willsellInfo","outputs":[{"name":"user","type":"address"},{"name":"price","type":"uint256"},{"name":"amount","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"amount","type":"uint256"},{"name":"token","type":"address"},{"name":"min_price_each","type":"uint256"},{"name":"bid_order","type":"uint256"},{"name":"frontend_refund","type":"address"}],"name":"sell","outputs":[{"name":"","type":"bool"}],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"token","type":"address"},{"name":"min_trade_amount","type":"uint256"}],"name":"findBestAsk","outputs":[{"name":"ask_order","type":"uint256"},{"name":"volume","type":"uint256"},{"name":"price","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"amount","type":"uint256"},{"name":"token","type":"address"},{"name":"price_each","type":"uint256"},{"name":"ask_order_spot","type":"uint256"}],"name":"willsell","outputs":[{"name":"","type":"bool"}],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"token","type":"address"},{"name":"bid_order","type":"uint256"}],"name":"willbuyInfo","outputs":[{"name":"user","type":"address"},{"name":"price","type":"uint256"},{"name":"amount","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"deposit","outputs":[{"name":"","type":"bool"}],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"token","type":"address"}],"name":"willsellFindSpot","outputs":[{"name":"ask_order_spot","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"token","type":"address"}],"name":"willbuyFindSpot","outputs":[{"name":"bid_order_spot","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"amount","type":"uint256"},{"name":"token","type":"address"},{"name":"max_price_each","type":"uint256"},{"name":"ask_order","type":"uint256"},{"name":"frontend_refund","type":"address"}],"name":"buy","outputs":[{"name":"","type":"bool"}],"payable":true,"stateMutability":"payable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"payable":true,"stateMutability":"payable","type":"fallback"},{"anonymous":false,"inputs":[{"indexed":false,"name":"amount","type":"uint256"},{"indexed":false,"name":"token","type":"address"},{"indexed":false,"name":"price_each","type":"uint256"},{"indexed":false,"name":"buyer","type":"address"},{"indexed":false,"name":"seller","type":"address"}],"name":"Trade","type":"event"}]
```

**[MINTABLE TEST TOKEN on ropsten](https://ropsten.etherscan.io/address/0x5D8b2400961546691214b495a501dE818939cfe2)**
### MINTABLE TEST TOKEN abi:
```js
[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_value","type":"uint256"},{"name":"_to","type":"address"}],"name":"mint","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"success","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"},{"name":"_spender","type":"address"}],"name":"allowance","outputs":[{"name":"remaining","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_from","type":"address"},{"indexed":true,"name":"_to","type":"address"},{"indexed":false,"name":"_value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_owner","type":"address"},{"indexed":true,"name":"_spender","type":"address"},{"indexed":false,"name":"_value","type":"uint256"}],"name":"Approval","type":"event"}]
```
