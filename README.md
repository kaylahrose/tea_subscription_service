# Tea Subscription Service


## RESTful Endpoints

<details close>


### Subscribe a customer to a tea subscription


```http
POST /api/v1/customers/:customer_id/teas/:tea_id/subscriptions
```

<details close>
<summary>  Details </summary>
<br>
    
Parameters: <br>
```
{
    "frequency": string,
    "price": integer
}
```

| Code | Description |
| :--- | :--- |
| 201 | `CREATED` |

Example Value:

```json
{
    "data": {
        "id": "4",
        "type": "subscription",
        "attributes": {
            "price": 10,
            "status": "active",
            "frequency": "monthly"
        }
    }
}
```

</details>

---
  
  
### Subscribe a customer to a tea subscription


```http
POST /api/v1/customers/:customer_id/teas/:tea_id/subscriptions
```

<details close>
<summary>  Details </summary>
<br>
    
Parameters: <br>
```
{
    "frequency": string,
    "price": integer
}
```

| Code | Description |
| :--- | :--- |
| 201 | `CREATED` |

Example Value:

```json
{
    "data": {
        "id": "4",
        "type": "subscription",
        "attributes": {
            "price": 10,
            "status": "active",
            "frequency": "monthly"
        }
    }
}
```

</details>

---
  
 
</details>
