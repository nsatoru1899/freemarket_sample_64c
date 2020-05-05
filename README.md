* Deployment instructions

* ...

# フリマアプリ DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string| null: false|
|familyname|string| null: false|
|firstname|string| null: false|
|familyname_kana|string| null: false|
|firstname_kana|string| null: false|
|phonenumber|string| unique: true|
|birth_date|date| null: false|
|detail|text|
|avatar|string|
|email|string|null: false, default: ""|
|encrypted_password|string|bull: false, default: ""|
|reset_password_taken|string|null: false, default: ""|
|reset_password_sent_at|datetime|
|remember_created_at|datetime|

### Association
- has_many :items, dependent: :destroy
- has_one :card dependent: :destroy
- has_one :address dependent: :destroy

## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|user|reference|null: false, foreign_key: true|
|postal_code|string|null: false|
|prefecture_code|integer|null: false|
|city|string| null: false|
|block|string| null: false|
|building|string|

### Association
- belongs_to :user


## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|card_id|string|null: false|
|customer_id|string|null: false|

### Association
- belongs_to :user


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string| null: false|
|ancestry|string| index: false|

### Association
- has_many :items


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|text|null: false|
|price|integer|null: false|
|brand|references| foreign_key: true|
|status_id|integer| null: false|
|charge_id|integer| null: false|
|prefecture_id|integer| null: false|
|day_id|integer| null: false|
|category|references| null: false, foreign_key: true|
|seller|references| null: false, foreign_key: {to_table: :users}|
|buyer|references| foreign_key: { to_table: :users}|

### Association
- has_many :images dependent: :destroy
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to :status
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|src|string|
|item|references|foreign_key: true|

### Association
- belongs_to :item