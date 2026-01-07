package main

import "fmt"

func main() {
    processes := []string{
        "System Analysis",
        "API Integration",
        "Module Development",
        "Testing & Deployment",
        "Client Training",
    }
    
    fmt.Println("Saloon ERP Implementation Processes:")
    for i, process := range processes {
        fmt.Printf("%d. %s\n", i+1, process)
    }
}
