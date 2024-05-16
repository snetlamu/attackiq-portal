## Deploy
```bash
EMAIL="attackiq_username" PASSWORD="attackiq_password" KEY="24_character_key_for_encryption" docker-compose up -d
```

## Destroy
```bash
docker-compose down
```

## To enable HTTPS, perform the following changes:

### Before-
* Directory Structure
```
├── README.md
├── config.hcl
├── docker-compose.yml
└── vault-init.sh
```

* docker-compose.yml
```yml
services:
  vault:
    image: vault:1.4.2
    container_name: vault
    hostname: vault
    ports:
      - 80:80
      # - 443:443
```

```yml
  attackiq:
    image: containers.cisco.com/snetlamu/attackiq-tenant-portal
    container_name: attackiq-app
    volumes:
      - vault-data:/tokens
      # - ./certs:/certs
```


### After-
* Directory Structure
```
├── README.md
├── certs
│   ├── server.cer
│   └── server.key
├── config.hcl
├── docker-compose.yml
└── vault-init.sh
```

* docker-compose.yml
```yml
services:
  vault:
    image: vault:1.4.2
    container_name: vault
    hostname: vault
    ports:
      - 443:443
```

```yml
  attackiq:
    image: containers.cisco.com/snetlamu/attackiq-tenant-portal
    container_name: attackiq-app
    volumes:
      - vault-data:/tokens
      - ./certs:/certs
```