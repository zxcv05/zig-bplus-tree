test "tests debug msg" {
    @import("std").debug.print("Ignore this message, this is only here to communicate that tests are running!\n", .{});
}
const std = @import("std");
const bpt = @import("bplustree").BPlusTree(i32, i32, 4);

test "duplicate key insert fails" {
    var tree = bpt.init(std.testing.allocator);
    defer tree.deinit();
    try tree.insert(1, 100);
    const err = tree.insert(1, 200);
    try std.testing.expectError(bpt.Error.DuplicateKey, err);
}

test "search in empty tree returns null" {
    var tree = bpt.init(std.testing.allocator);
    defer tree.deinit();
    try std.testing.expect(tree.search(42) == null);
}

test "insert many and search all" {
    var tree = bpt.init(std.testing.allocator);
    defer tree.deinit();
    var i: i32 = 0;
    while (i < 100) : (i += 1) {
        try tree.insert(i, i);
    }
    i = 0;
    while (i < 100) : (i += 1) {
        try std.testing.expect(tree.search(i) == i);
    }
}
