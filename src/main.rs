#[macro_use]
extern crate rocket;

#[get("/is-even/<x>")]
fn is_even(x: i32) -> String {
    let res = x % 2 == 0;
    res.to_string()
}

#[get("/health")]
fn health() -> String {
    String::from("not dead")
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![is_even, health])
}
