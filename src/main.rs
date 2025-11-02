use filtile::{FilTile, TagLog, config::ConfigStorage};
use river_layout_toolkit::{Layout, run};
use std::env;

fn main() {
    let all_args: Vec<String> = env::args().collect();

    if all_args.len() > 1 {
        match all_args[1].as_str() {
            "-h" => println!("usage: filtile [options]"),
            "-version" => println!("{}", env!("CARGO_PKG_VERSION")),
            _ => eprintln!("error: unknown option '{}'", all_args[1]),
        }
        return;
    }

    let mut layout = FilTile {
        tag_log: TagLog::new(),
        configs: ConfigStorage::new(),
    };

    let call_string = all_args[1..].join(" ").trim().to_string();

    if !call_string.is_empty() {
        let _ = layout.user_cmd(call_string, None, "all");
    }

    run(layout).unwrap();
}
