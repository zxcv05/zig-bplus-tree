const std = @import("std");
const bpt = @import("bplustree").BPlusTree(i32, i32, 4);

pub fn main() !void {
    var dbga: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbga.deinit();

    var tree = bpt.init(dbga.allocator());
    defer tree.deinit();

    try tree.insert(10, 100);
    try tree.insert(20, 200);
    try tree.insert(5, 50);

    const found = tree.search(10);
    std.debug.print("Found 10: {any}\n", .{found});

    const not_found = tree.search(99);
    std.debug.print("Not found 99: {any}\n", .{not_found});
}
