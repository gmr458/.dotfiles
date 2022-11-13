use std::process::Command;
use std::str::from_utf8;

fn main() {
    let output = Command::new("playerctl")
        .arg("status")
        .output()
        .expect("`playerctl status` command failed");

    let message = output.stdout;

    let message = match from_utf8(&message) {
        Ok(v) => {
            let mut s = v.to_string();
            s.pop();
            s
        },
        Err(e) => panic!("Invalid UTF8 sequence: {}", e),
    };

    let message = message.as_str();

    match message {
        "Playing" => println!("%{{A1:playerctl pause:}}󰏤%{{A}}󰎇 "),
        "Paused" => println!("%{{A1:playerctl play:}}󰐊%{{A}}󰎇 "),
        _ => println!(""),
    }
}
