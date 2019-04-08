#Working on functions in R
#translate Farenheit to Kelvin
far_to_kel <- function(temp) {
  kelvin <- ((temp - 32)*(5/9)) + 273.15
  return(kelvin)
}
#the return is just to clarify what we will be getting at the end

far_to_kel(0)
far_to_kel(32)

# write a function of Kelvin to Celsius
kel_to_cel <-  function(temp) {
  celsius <- ((temp - 273.15))
  return(celsius)
}
# the function() just names the function(value to be evaluated)
kel_to_cel(273.15)
kel_to_cel(475)

# namespace within a function is accessible only within the function
# try nesting functions convert F to C using these two functions
far_to_cel <- function(temp) {
  celsius <- ((temp - 32)*(5/9))
  return(celsius)
}
far_to_cel(32)

# to nest
far_to_cel <- function(temp) {
  celsius <- kel_to_cel(far_to_kel(temp))
  return(celsius)
}
far_to_cel(32)

#another way is to do it in two parts:
far_to_cel_2 <- function(temp) {
  kel <- far_to_kel(temp)
  celsius <- kel_to_cel(kel)
  return(celsius)
}
far_to_cel_2(32)
