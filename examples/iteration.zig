const std = @import("std");
const bpt = @import("bplustree").BPlusTree(i32, i32, 4);

pub fn main() !void {
    var dbga: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbga.deinit();

    var tree = bpt.init(dbga.allocator());
    defer tree.deinit();

    try tree.insert(1, 10);
    try tree.insert(2, 20);
    try tree.insert(3, 30);
    try tree.insert(4, 40);

    // This tree does not yet have an iterator, but you can search for all keys:
    var k: i32 = 1;
    while (k < 5) : (k += 1) {
        const v = tree.search(k);
        std.debug.print("Key {d} => {any}\n", .{ k, v });
    }
}
