# Group Transactions  

> Author: Mahdi Aouchiche (<https://github.com/mahdi-aouchiche/group_transactions>)

## Overview

For a given array of transactions, group all of the transactions by item name. Return an array of strings where each string contains the item name followed by a space and the number of associated transactions.

**Function Description:**

```code
groupTransactions(transactions[]);
```

The function has the following parameter(s): `string transactions[n]`  
each `transactions[i]` denotes the item name in the `i'th` transaction.  

The function returns: `string[]`  
a sorted string array, each string is in the form `"item_name transaction_count"`.

> **Note:** Sort the array descending by transaction count, then ascending alphabetically by item name for items with matching transaction counts.

### Example 1

Array ```transactions = ['notebook', 'notebook', 'mouse', 'keyboard', 'mouse']```.  
The function returns: ```['mouse 2', 'notebook 2', 'keyboard 1']```.  
**Explanation:**  
    *There are two items 'notebook' and 'mouse' with 2 transactions each.  
    *In alphabetical order, they are 'mouse', 'notebook'.  
    *There is one item 'keyboard' with 1 transaction.  
    *The return array sorted descending by transaction count, then ascending by name.

### Example 2

Array ```transactions = ['bin', 'can', 'bin', 'bin']```.  
The function returns: ```['bin 3','can 1']```.  
**Explanation:**  
    *There is one item 'bin' with 3 transactions.  
    *There is one item 'can' with 1 transaction.  
    *The return array sorted descending by transaction count, then ascending by name.  

### Example 3

Array ```transactions = ['banana', 'pear', 'apple']```.  
The function returns: ```['apple 1', 'banana 1', 'pear 1']```.  
**Explanation:**  
    *There is one item 'apple' with 1 transaction.  
    *There is one item 'banana' with 1 transaction.  
    *There is one item 'pear' with 1 transaction.  
    *The return array sorted descending by transaction count, then ascending by name.  

---

#### To run the project in java, you can use the following command

```bash
bash run-tests.sh java 
```

#### To run the project in c++, you can use the following command

```bash
bash run-tests.sh cpp 
```
