// M-DOD Real-time Stream Processing Engine
package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net"
	"time"
)

type SensorPacket struct {
	Domain     string    `json:"domain"`
	Timestamp  time.Time `json:"timestamp"`
	Latitude   float64   `json:"lat"`
	Longitude  float64   `json:"lon"`
	Value      float64   `json:"value"`
	Confidence float64   `json:"confidence"`
}

func processStream(conn net.Conn) {
	defer conn.Close()
	decoder := json.NewDecoder(conn)
	for {
		var packet SensorPacket
		if err := decoder.Decode(&packet); err != nil {
			log.Printf("Decode error: %v", err)
			return
		}
		// Threat detection logic
		if packet.Value > 0.8 && packet.Confidence > 0.7 {
			log.Printf("THREAT DETECTED: %s at %.4f,%.4f", 
				packet.Domain, packet.Latitude, packet.Longitude)
		}
	}
}

func main() {
	ln, err := net.Listen("tcp", ":9090")
	if err != nil {
		log.Fatal(err)
	}
	for {
		conn, err := ln.Accept()
		if err != nil {
			log.Print(err)
			continue
		}
		go processStream(conn)
	}
}
