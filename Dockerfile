# Step 1: Build the Go application
FROM golang:1.20-alpine AS build_image

# Install git
RUN apk add --no-cache git

# Clone the repository
RUN git clone https://github.com/Oluty-1/apex-network_mod.git /build/apex-network_mod
WORKDIR /build/apex-network_mod
RUN git checkout CI/CD-EBS

LABEL "Project"="Apex_Network"
LABEL "Author"="Tejiri"


# Copy Go module files
COPY src/go.mod .
COPY src/ .
COPY .env .

# Download go dependencies
RUN go mod download

# Build the Go application
RUN go build -o /build/apex_network



# Step 2: Create a minimal container to run the application
FROM alpine:latest

# Set a working directory in the new container
WORKDIR /app

# Copy the built Go binary from the builder stage
COPY --from=build_image /build/apex_network ./apex_network

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD [ "./apex_network", "apex_network_api" ]

