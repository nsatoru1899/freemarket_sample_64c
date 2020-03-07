* Deployment instructions

* ...

# フリマアプリ DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|familyname|string| null: false|
|firstname|string| null: false|
|familyname_kana|string| null: false|
|firstname_kana|string| null: false|
|phonenumber|integer| null: false, unique: true|
|birth_date|date| null: false|
|detail|text|null: true|

### Association
- has_many :items, through: :likes
- has_many :likes
- has_many :items, through: :comments
- has_many :comments
- has_one :card
- has_one :address

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|price|integer|null: false|
|brand_id|reference| foreign_key: true|
|status_id|reference| null: false, foreign_key: true|
|charge_id|reference| null: false, foreign_key: true|
|prefecture_code|code| null: false|
|days_id|reference| null: false, foreign_key: true|
|category_id|reference| null: false, foreign_key: true|
|seller_id|reference| null: false, foreign_key: true|
|buyer_id|reference| foreign_key: true|

### Association

- has_many :users, through: :likes
- has_many :likes
- has_many :users, through: :comments
- has_many :comments
- has_many :images
- belongs_to :category
- belongs_to :brand
- belongs_to :status
- belongs_to :charge
- belongs_to :day
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"

## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|postal_code|string|null: false|
|prefecture_code|code|null: false|
|city|string| null: false|
|block|string| null: false|
|building|string| null: true|

### Association

- belongs_to :user

## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|reference|null: false, foreign_key: true|
|path|string|null: false|

### Association

- belongs_to :item

## item_statusesテーブル

|Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association

- has_many :items

## chargesテーブル

|Column|Type|Options|
|------|----|-------|
|charge|string|null: false|

### Association
- has_many :items

## daysテーブル

|Column|Type|Options|
|------|----|-------|
|days|string|null: false|

### Association
- has_many :items

## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|brand|string|null: false|

### Association
- has_many :items

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|card_id|string|null: false|
|customer_id|string|null: false|

### Association
- belongs_to :user
 
## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|
|content|text|null: false|

### Association
- belongs_to :user
- belongs_to :item

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|

### Association
- has_many :items