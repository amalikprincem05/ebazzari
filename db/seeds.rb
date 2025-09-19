User.create!(email: "admin@example.com", password: "password", role: :admin, approved: true)
owner = User.create!(email: "owner@example.com", password: "password", role: :owner, approved: true)
shop = owner.shops.create!(name: "Demo Shop", description: "A demo shop", approved: true)
shop.products.create!(name: "Sample Product", description: "Demo item", price: 19.99, stock: 10)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?