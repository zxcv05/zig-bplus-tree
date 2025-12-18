const std = @import("std");
const bpt = @import("bplustree").BPlusTree(i32, i32, 4);

pub fn main() !void {}

// Basic insert/search test
test "insert and search" {
    var tree = bpt.init(std.testing.allocator);
    defer tree.deinit();
    try tree.insert(1, 100);
    try tree.insert(2, 200);
    try tree.insert(3, 300);
    try std.testing.expect(tree.search(1) == 100);
    try std.testing.expect(tree.search(2) == 200);
    try std.testing.expect(tree.search(3) == 300);
    try std.testing.expect(tree.search(99) == null);
}
