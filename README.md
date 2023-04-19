# Tea Subscription Service

## Summary
This repository is a Rails API for a Tea Subscription Service that satisfies the following requirements:

An endpoint to subscribe a customer to a tea subscription
An endpoint to cancel a customer’s tea subscription
An endpoint to see all of a customer’s subsciptions (active and cancelled)

Project specifications can be found [here](https://mod4.turing.edu/projects/take_home/take_home_be).

## Installation

1. Fork and clone this repository
2. `cd` into the root directiory
3. `bundle install`
4. `rails db:{drop,create,migrate,seed}`
5. Run the test suite with `bundle exec rspec`
6. Start the local server by running `rails s`
7. Visit the app on `http://127.0.0.1:3000` in your web browser

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

## Status Codes

Onyva returns the following status codes in its API:

| Status Code | Description |
| :--- | :--- |
| 200 | `OK` |
| 201 | `CREATED` |
| 400 | `BAD REQUEST` |
| 404 | `NOT FOUND` |
| 500 | `INTERNAL SERVER ERROR` |
