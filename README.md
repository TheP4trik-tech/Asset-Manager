# README
About
Ruby on Rails 8 for managing real estate portfolios, buildings, and internal assets.
This project demonstrates  Rails patterns, including role-based access control, 
automated audit logs, and complex data relationships.

Hierarchical Data Structure:
User -> Building -> Room -> Asset(QR,attachments)

Main Features:
- User Management
- Asset Management
- Asset audit logs
- Role-Based Access Control
- Search & CSV export of assets
- QR Code generation for assets

Modern approach:
Web sockets for real-time updates(only in bulding page)
StimulusJS for dependent select in Asset#edit
Tailwind CSS for styling
Turbo Frames for AJAX

Additional Features:
- API endpoints for assets, buildings, and rooms

How to run the app:
- Clone the repository
- Run bundle install (if you don't have bundler installed, run gem install bundler)
- Run rails db:migrate
- Run rails db:seed
- Run rails s + rails tailwindcss:build
- Login either by creating a new user or using the seed data:
do rails c and run: (u = User.last, u.email) to get the email, pass is always 123456
if want to switch between roles, u.role = "super_admin" etc
- Visit http://localhost:3000/
- 



