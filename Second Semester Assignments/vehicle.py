class Vehicle:
    def __init__(self, make, model, year:int, mileage=0):
        self.make = make
        self.model = model
        self.year = year
        self._mileage = mileage

    def drive(self, distance):
        if distance > 0:
            self._mileage += distance
        else:
            print("Distance driven must be a positive number.")

    def get_info(self):
        return f"{self.make}-{self.model}-{self.year}, Mileage: {self._mileage} miles"
    
    def __str__(self):
        # readable string representation
        return f"{self.make} {self.model} ({self.year}) with {self._mileage} miles"
    
    @classmethod
    def from_string(cls, vehicle_str):
        make, model, year = vehicle_str.split('-')
        return cls(make, model, year)
    
class Car(Vehicle):
    # Class level attribute
    vehicle_type = "Car"

    def __init__(self, make, model, year:int, mileage=0, fuel_capacity = 0):
        super().__init__(make, model, year, mileage)
        self.fuel_capacity = fuel_capacity

    # Overrides get_info() from the parent class (Vehicle) to include fuel capacity
    def get_info(self):
        return (f"Car info: {super().get_info()}, Fuel Capacity: {self.fuel_capacity} litres")
    
class ElectricScooter(Vehicle):
    vehicle_type = "Electric Scooter"

    def __init__(self, make, model, year:int, mileage=0, battery_percentage=0):
        super().__init__(make, model, year, mileage)
        self.battery_percentage = battery_percentage

    # Overrides drive() from the parent class (Vehicle) to decrease battery percentage
    def drive(self, distance):
        if distance > 0:
            super().drive(distance)
            battery_loss = distance // 10
            self.battery_percentage = max(0, self.battery_percentage - battery_loss)
        else:
            print("Distance driven must be a positive number.")

    def get_info(self):
        """Override to include battery info."""
        return (f"Electric Scooter info: {super().get_info()}, Battery Percentage: {self.battery_percentage}%")
    
    @staticmethod
    def is_chargining_required(battery_percentage):
        if battery_percentage < 20:
            return True
        else:
            return False
        
def print_vehicle_report(vehicles):
    for v in vehicles:
        print(v.get_info())


    
#Usage
vehicles = [
    Car("Toyota", "Corolla", 2020, fuel_capacity= 50),
    ElectricScooter("Xiaomi", "M365", 2022, battery_percentage= 85),
    Vehicle.from_string("Honda-Civic-2018")
]

for v in vehicles:
    v.drive(100)

print_vehicle_report(vehicles)

# Check if charging is required for the electric scooter
scooter= ElectricScooter("Xiaomi", "M365", 2022, battery_percentage= 15)
scooter2= ElectricScooter("Segway", "Ninebot", 2021, battery_percentage= 50)
print(f"Is charging required for scooter1? {ElectricScooter.is_chargining_required(scooter.battery_percentage)}")
print(f"Is charging required for scooter2? {ElectricScooter.is_chargining_required(scooter2.battery_percentage)}")        