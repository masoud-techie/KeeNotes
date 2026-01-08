# 📝 Kee-Notes - Note taking App (Ruby on Rails)

[![Live App](https://img.shields.io/badge/Live-App-success)](https://www.kee-notes.blog/)

You can access the live version of KeeNotes here: 👉 [https://www.kee-notes.blog](https://www.kee-notes.blog/)

KeeNotes is a simple and clean **Notes application** built with **Ruby on Rails** that allows users to sign up, log in, and manage their personal notes securely. The app uses **Devise** for authentication and **Bootstrap 5** for a modern, responsive UI.
* * *

## 🚀 Features

- User authentication (Sign up, Log in, Log out)
- Create, edit, and delete notes
- Notes belong to the logged-in user only
- Display note creation date
- Display updated date only when a note is modified
- Favorite notes functionality (hidden when no notes exist)
- Responsive UI using Bootstrap 5

* * *

## 🛠 Tech Stack

- **Ruby** 3.2+
- **Ruby on Rails** 7+
- **Devise** – Authentication
- **Bootstrap 5** – Styling
- **PostgreSQL** - (production)
- **SQLite** - (development)
- **ERB** – Views
- **Heroku** - (Deployment)

* * *

## ⚙️ Setup & Installation

### 1: Clone the repository

```
git clone https://github.com/masoud-techie/note_taking_app.git
cd note_taking-app
```

### 2: Install Dependencies

```
bundle install
```

### 3: Setup the database

```
rails db:create
rails db:migrate
```

### 4: Run the server

```
rails server
```

#### Then visit:

```
http://localhost:3000
```

## 🔐 Authentication

This app uses **Devise** for user authentication.

Included Devise pages:

- Sign up

- Login
    
- Forgot password - (Under development)
    
- Password reset - (Under development)
    

All authentication pages share a consistent Bootstrap-based layout.

## 🔮 Future Enhancements

- Admin role
    
- Note categories/tags
    
- Search and filtering
    
- Rich text editor
    
- Sharing notes ✅
    
- API support
    
- Dark mode
    

## 🤝 Contributing

Contributions are welcome!

1.  Fork the project
    
2.  Create your feature branch  
    `git checkout -b feature/my-feature`
    
3.  Commit your changes  
    `git commit -m "Add my feature"`
    
4.  Push to the branch  
    `git push origin feature/my-feature`
    
5.  Open a Pull Request
    

* * *

## 📄 License

This project is open source and available under the **MIT License**.