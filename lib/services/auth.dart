import 'models.dart';
import 'package:rxdart/rxdart.dart';

class CurrentCustomer {
  final BehaviorSubject<Customer>? _currentCustomer =
      BehaviorSubject<Customer>.seeded(Customer(
          aadharNo: 0, creditScore: 0, income: 0, custId: 0, password: ''));

  Stream<Customer> get currentCustomer => _currentCustomer!.stream;

  Customer get currentCustomerValue => _currentCustomer!.value;

  logout() {
    _currentCustomer!.sink.add(Customer(
        aadharNo: 0, creditScore: 0, income: 0, custId: 0, password: ''));
  }

  login(Customer cust) {
    _currentCustomer!.sink.add(cust);
  }
}

CurrentCustomer currentCustomer = CurrentCustomer();

class CurrentEmployee {
  final BehaviorSubject<Employee>? _currentEmployee =
      BehaviorSubject<Employee>.seeded(
    Employee(
        empId: 0,
        salary: 0,
        password: '', 
        aadharNo: 0, 
        branchId: 0, 
        doj: DateTime.now(),
      ),
  );

  Stream<Employee> get currentEmployee => _currentEmployee!.stream;

  Employee get currentEmployeeValue => _currentEmployee!.value;

  logout() {
    _currentEmployee!.sink.add(
      Employee(
        empId: 0,
        salary: 0,
        password: '', 
        aadharNo: 0, 
        branchId: 0, 
        doj: DateTime.now(),
      ),
    );
  }

  login(Employee employee) {
    _currentEmployee!.sink.add(employee);
  }
}

CurrentEmployee currentEmployee = CurrentEmployee();
