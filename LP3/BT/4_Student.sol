// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

contract StudentManagement {

    struct Student {
        int stud_id;
        string Name;
        string Department;
    }

    // Mapping for more efficient student lookup
    mapping(int => Student) private students;

    // Add a new student
    function addStudent(int stud_id, string memory Name, string memory Department) public {
        students[stud_id] = Student(stud_id, Name, Department);
    }

    // Retrieve student details by ID
    function getStudent(int stud_id) public view returns (string memory, string memory) {
        Student memory stud = students[stud_id];
        
        // Check if the student exists by verifying if the ID matches
        if (stud.stud_id == stud_id) {
            return (stud.Name, stud.Department);
        } else {
            return ("Name Not Found", "Department Not Found");
        }
    }

    // Fallback function, adds a default student if called with ETH but no data
    fallback() external payable {
        addStudent(7, "XYZ", "Mechanical");
    }
    
    // Receive function to accept ETH without any function call or data
    receive() external payable {}
}
