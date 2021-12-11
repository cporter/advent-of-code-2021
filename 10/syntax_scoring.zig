const std = @import("std");

fn score_bad(x: u8) usize {
    if (x == ')') {
        return 3;
    } else if (x == ']') {
        return 57;
    } else if (x == '}') {
        return 1197;
    } else if (x == '>') {
        return 25137;
    } else {
        return 100000000;
    }
}

fn matches(a: u8, b: u8) bool {
    return (a == '<' and b == '>') or
        (a == '{' and b == '}') or
        (a == '[' and b == ']') or
        (a == '(' and b == ')');
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = &std.io.getStdIn().reader();
    var buf: [256]u8 = undefined;

    var lines: i32 = 0;
    var chars: usize = 0;

    var bad_score: usize = 0;
    var good_score: usize = 0;

    while (true) {
        if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
            var stack: [256]u8 = undefined;
            var stack_ptr: usize = 0;
            for (user_input) |ch| {
                if ((ch == '{') or (ch == '[') or (ch == '<') or (ch == '(')) {
                    stack[stack_ptr] = ch;
                    stack_ptr += 1;
                } else {
                    if (stack_ptr == 0 or !matches(stack[stack_ptr - 1], ch)) {
                        var bad = score_bad(ch);
                        bad_score += bad;
                        // try stdout.print("bad {c}/{c} {d} on line {d}\n", .{ stack[stack_ptr - 1], ch, bad, lines });
                        break;
                    } else {
                        stack_ptr -= 1;
                    }
                }
            }
        } else {
            break;
        }
        lines += 1;
    }

    try stdout.print("part 1: {d}\n", .{bad_score});
    try stdout.print("part 2: {d}\n", .{good_score});
}
