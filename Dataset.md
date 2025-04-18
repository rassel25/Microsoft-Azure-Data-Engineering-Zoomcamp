# About the Dataset

- business.json: Contains business data including location data, attributes, and categories.

```
business.json
 |-- address: string (nullable = true)
 |-- attributes: struct (nullable = true)
 |    |-- AcceptsInsurance: string (nullable = true)
 |    |-- AgesAllowed: string (nullable = true)
 |    |-- Alcohol: string (nullable = true)
 |    |-- Ambience: string (nullable = true)
 |    |-- BYOB: string (nullable = true)
 |    |-- BYOBCorkage: string (nullable = true)
 |    |-- BestNights: string (nullable = true)
 |    |-- BikeParking: string (nullable = true)
 |    |-- BusinessAcceptsBitcoin: string (nullable = true)
 |    |-- BusinessAcceptsCreditCards: string (nullable = true)
 |    |-- BusinessParking: string (nullable = true)
 |    |-- ByAppointmentOnly: string (nullable = true)
 |    |-- Caters: string (nullable = true)
 |    |-- CoatCheck: string (nullable = true)
 |    |-- Corkage: string (nullable = true)
 |    |-- DietaryRestrictions: string (nullable = true)
 |    |-- DogsAllowed: string (nullable = true)
 |    |-- DriveThru: string (nullable = true)
 |    |-- GoodForDancing: string (nullable = true)
 |    |-- GoodForKids: string (nullable = true)
 |    |-- GoodForMeal: string (nullable = true)
 |    |-- HairSpecializesIn: string (nullable = true)
 |    |-- HappyHour: string (nullable = true)
 |    |-- HasTV: string (nullable = true)
 |    |-- Music: string (nullable = true)
 |    |-- NoiseLevel: string (nullable = true)
 |    |-- Open24Hours: string (nullable = true)
 |    |-- OutdoorSeating: string (nullable = true)
 |    |-- RestaurantsAttire: string (nullable = true)
 |    |-- RestaurantsCounterService: string (nullable = true)
 |    |-- RestaurantsDelivery: string (nullable = true)
 |    |-- RestaurantsGoodForGroups: string (nullable = true)
 |    |-- RestaurantsPriceRange2: string (nullable = true)
 |    |-- RestaurantsReservations: string (nullable = true)
 |    |-- RestaurantsTableService: string (nullable = true)
 |    |-- RestaurantsTakeOut: string (nullable = true)
 |    |-- Smoking: string (nullable = true)
 |    |-- WheelchairAccessible: string (nullable = true)
 |    |-- WiFi: string (nullable = true)
 |-- business_id: string (nullable = true)
 |-- categories: string (nullable = true)
 |-- city: string (nullable = true)
 |-- hours: struct (nullable = true)
 |    |-- Friday: string (nullable = true)
 |    |-- Monday: string (nullable = true)
 |    |-- Saturday: string (nullable = true)
 |    |-- Sunday: string (nullable = true)
 |    |-- Thursday: string (nullable = true)
 |    |-- Tuesday: string (nullable = true)
 |    |-- Wednesday: string (nullable = true)
 |-- is_open: long (nullable = true)
 |-- latitude: double (nullable = true)
 |-- longitude: double (nullable = true)
 |-- name: string (nullable = true)
 |-- postal_code: string (nullable = true)
 |-- review_count: long (nullable = true)
 |-- stars: double (nullable = true)
 |-- state: string (nullable = true)
```

- review.json: Contains full review text data including the user_id that wrote the review and the business_id the review is written for.

```json
{
  "review_id": "KU_O5udG6zpxOg-VcAEodg",
  "user_id": "mh_-eMZ6K5RLWhZyISBhwA",
  "business_id": "XQfwVwDr-v0ZS3_CbbE5Xw",
  "stars": 3,
  "useful": 0,
  "funny": 0,
  "cool": 0,
  "text": "If you decide to eat here, just be aware it is going to take about 2 hours from beginning to end. We have tried it multiple times, because I want to like it! I have been to it's other locations in NJ and never had a bad experience. \n\nThe food is good, but it takes a very long time to come out. The waitstaff is very young, but usually pleasant. We have just had too many experiences where we spent way too long waiting. We usually opt for another diner or restaurant on the weekends, in order to be done quicker.",
  "date": "2018-07-07 22:09:11",
  "id": "783e84ba-40e0-4c08-9426-40f25d520514",
  "_rid": "8pxVAI1YAQsBAAAAAAAAAA==",
  "_self": "dbs/8pxVAA==/colls/8pxVAI1YAQs=/docs/8pxVAI1YAQsBAAAAAAAAAA==/",
  "_etag": "\"170040a8-0000-0100-0000-660250d10000\"",
  "_attachments": "attachments/",
  "_ts": 1711427793
}
```

```md
the nature of the data contained in each field:

1. **review_id**: A unique identifier for the review. It's a string of characters.
2. **user_id**: A unique identifier for the user. Like review_id, it's a string.
3. **business_id**: A unique identifier for the business being reviewed. Again, it's a string.
4. **stars**: This represents the rating given by the user. Typically, this is an integer. However, if half-star ratings are possible, it could be a float.
5. **useful**, **funny**, **cool**: These are likely counts of how many times a review was tagged as useful, funny, or cool, respectively. They should be integers.
6. **text**: The actual text of the review. This is a string.
7. **date**: The date and time when the review was posted. This is best represented as a datetime object.
8. **id**: Appears to be another unique identifier, possibly for the record itself. It's a string.
9. **\_rid**, **\_self**, **\_etag**, **\_attachments**: These look like internal identifiers and metadata used by the database system (possibly for document indexing, referencing, and versioning). They are all strings.
10. **\_ts**: This seems to be a timestamp, likely indicating when the record was last updated. This would typically be an integer representing time in Unix epoch format (seconds since Jan 1, 1970).

Based on this understanding, here's a suggested data type for each field:

- **review_id**: String
- **user_id**: String
- **business_id**: String
- **stars**: Integer (or Float if half-stars are possible)
- **useful**: Integer
- **funny**: Integer
- **cool**: Integer
- **text**: String
- **date**: Datetime
- **id**: String
- **\_rid**: String
- **\_self**: String
- **\_etag**: String
- **\_attachments**: String
- **\_ts**: Integer (Unix epoch time)
```

- user.json: User data including the user's friend mapping and all the metadata associated with the user.

```
user.json
|-- average_stars: double (nullable = true)
 |-- compliment_cool: long (nullable = true)
 |-- compliment_cute: long (nullable = true)
 |-- compliment_funny: long (nullable = true)
 |-- compliment_hot: long (nullable = true)
 |-- compliment_list: long (nullable = true)
 |-- compliment_more: long (nullable = true)
 |-- compliment_note: long (nullable = true)
 |-- compliment_photos: long (nullable = true)
 |-- compliment_plain: long (nullable = true)
 |-- compliment_profile: long (nullable = true)
 |-- compliment_writer: long (nullable = true)
 |-- cool: long (nullable = true)
 |-- elite: string (nullable = true)
 |-- fans: long (nullable = true)
 |-- friends: string (nullable = true)
 |-- funny: long (nullable = true)
 |-- name: string (nullable = true)
 |-- review_count: long (nullable = true)
 |-- useful: long (nullable = true)
 |-- user_id: string (nullable = true)
 |-- yelping_since: string (nullable = true)
```

- checkin.json: Checkins on a business.

```
checkin.json
 |-- business_id: string (nullable = true)
 |-- date: string (nullable = true)
```

- tip.json: Tips are written by a user of a business. Tips are shorter than reviews and tend to convey quick suggestions.

```

```
