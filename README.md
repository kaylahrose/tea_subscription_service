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
  
  
### Cancel a customer’s tea subscription


```http
PATCH /api/v1/subscriptions/:id
```

<details close>
<summary>  Details </summary>
<br>
    
Parameters: <br>
```
none
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "price": 10,
            "status": "inactive",
            "frequency": "monthly"
        }
    }
}
```

</details>

---
    
      
### View all of a customer’s subsciptions (active and cancelled)


```http
GET /api/v1/customers/:id/subscriptions
```

<details close>
<summary>  Details </summary>
<br>
    
Parameters: <br>
```
none
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "price": 10,
                "status": "inactive",
                "frequency": "monthly"
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "price": 10,
                "status": "active",
                "frequency": "monthly"
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "price": 10,
                "status": "active",
                "frequency": "monthly"
            }
        },
        {etc},
        {etc}
    ]
}
```

</details>

---
  
 
</details>
