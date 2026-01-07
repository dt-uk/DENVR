#include <iostream>
#include <vector>
#include <string>

int main() {
    std::vector<std::string> tools = {
        "Postman", "Docker", "Git", "VSCode", 
        "Node.js", "Python", "React", "PostgreSQL"
    };
    
    std::cout << "Saloon ERP Development Tools:\n";
    for (const auto& tool : tools) {
        std::cout << "• " << tool << std::endl;
    }
    return 0;
}
