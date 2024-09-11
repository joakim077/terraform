# List
variable "list" {
  type = list(number)
  default = [ 0,1,2,3,4,5,6]
}

output "list" {
  value = var.list
}

#List of Objects
variable "Object" {
  type = list(object({
    firstanme = string
    lastname = string
    age = number
  }))

  default = [{
    firstanme = "raju"
    lastname = "rastogi"
    age = 24
  },
  {
    firstanme = "R"
    lastname = "Madhvan"
    age = 25
  }]
}

output "object" {
  value = var.Object
}

#Map: key value pair
variable "map_eg" {
  type = map(number)

  default = {
    "one" = 1
    "two" = 2
    "three" = 3
    "four" = 4
  }
}

output "map_eg" {
  value = var.map_eg
}


#Set: same as list but duplicates are not allowed
variable "set" {
  type = set(number)
  default = [1,2,3,4,2]
}

output "set" {
  value = var.set
}

locals {
  add = 2+3
  sub = 5-1
  div = 5/2
  rem = 9%6
  mul = 8*2

# double the list
list-2 = [for num in var.list1: num*2]

# get Odd number from list
list-odd = [for num in var.list1: num if num%2 !=0]

# get lastname from Object list
lastName = [for person in var.Object: person.lastname]

# Map -> list of Numbers
editMap = [for key, value in var.map_eg: value*2]

# Map -> list of map
map_double = {for key, value in var.map_eg: key => value*5}


}

output "opt" {
  value = local.editMap

}
variable "list1" {
 type = list(number)
 default = [ 1,2,3,4,5]
}
