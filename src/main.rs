use filtile::{FilTile, TagLog, config::ConfigStorage};
use river_layout_toolkit::{Layout, run};
use std::env;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args: Vec<String> = env::args().collect();

    if args.len() == 2 {
        match args[1].as_str() {
            "-h" => println!("usage: filtile [options]"),
            "-version" => println!("{}", env!("CARGO_PKG_VERSION")),
            _ => eprint!("error: unknown option '{}'", args[1]),
        }
    }

    let mut layout = FilTile {
        tag_log: TagLog::new(),
        configs: ConfigStorage::new(),
    };

    let call_string = args[1..].join(" ").trim().to_string();

    if !call_string.is_empty() {
        layout.user_cmd(call_string, None, "all")?
    }

    run(layout)?;

    Ok(())
}
