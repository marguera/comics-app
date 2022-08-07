## Getting Started

### Clone the repository:
```
git clone https://github.com/marguera/comics-app.git
```

### At the command prompt, change directory to `comics-app` 
```
cd comics-app
```

### Create the .env.development file:
```
touch comics-api/.env.development
```

### Inside of .env.development set your auth environment variables:
```
MARVEL_PUBLIC_KEY=your public key
MARVEL_PRIVATE_KEY=your private key
```

### Run the service (make sure the port `3000` is not being used):
```
docker-compose up --build
```

### Open the browser and navigate to:
```
http://localhost:3000
```

## Testing

### Rails
```
docker-compose run --rm comics-api rspec -fd
```

### React
```
TODO
```