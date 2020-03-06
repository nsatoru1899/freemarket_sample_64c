# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# メルカリアプリ DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false, unique: true|
|buyed_items_id|reference| foreign_key: "buyer_id", class_name: "Item"|
|selling_items_id|reference|{ where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"|
|sold_items_id|reference|{ where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"|

### Association
- has_many :items, through: :likes
- has_many :likes
- has_many :items, through: :comments
- has_many :comments
- has_many :buyed_items
- has_many :selling_items
- has_many :sold_items
- belongs_to :profile
- belongs_to :card
- belongs_to :address

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, foregin_key: true|
|detail|text|null: false, foregin_key: true|
|price|integer|null: false, foregin_key: true|
|brand_id|reference| null: false, foreign_key: true|
|status_id|reference| null: false, foreign_key: true|
|charge_id|reference| null: false, foreign_key: true|
|prefecture_code|code| null: false|
|days_id|reference| null: false, foreign_key: true|
|category_id|reference| null: false, foreign_key: true|
|seller_id|reference| null: false, foreign_key: true|
|buyer_id|reference| null: false, foreign_key: true|

### Association
- has_many :items, through: :likes
- has_many :likes
- has_many :items, through: :comments
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
|user_id|reference|null: false, foregin_key: true|
|postal-code|text|null: false|
|prefecture_code|code|foregin_key: true|
|city|text| null: false|
|block|integer| null: false|
|building|text| null: false|

### Association
- belongs_to :user

## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|reference|null: false, foregin_key: true|
|path|string|null: false|
### Association
- belongs_to :item

## profilesテーブル

|Column|Type|Options|
|------|----|-------|
|familyname|string| null: false|
|firstname|string| null: false|
|familyname_kana|string| null: false|
|firstname_kana|string| null: false|
|phonenumber|integer| null: false|
|birth_date|date| null: false|
|detail|text|null: true|
|user_id|reference|null: false, foregin_key: true|
### Association
- belongs_to :user

## item_statusテーブル

|Column|Type|Options|
|------|----|-------|
|status|text|null: false|
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
|days|string|null: false, foregin_key: true|
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
|user_id|reference|null: false, foregin_key: true|
|card_id|reference|null: false|
|customer_id|reference|null: false|
### Association
- belongs_to :user

## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foregin_key: true|
|item_id|reference|null: false, foregin_key: true|
|content|text|null: false|
### Association
- belongs_to :user
- belongs_to :item

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foregin_key: true|
|item_id|reference|null: false, foregin_key: true|
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