## JSON File Structure

The question bank is organized by **levels**, with each level stored as a top-level key such as `level_1`, `level_5`, or `level_6`. Each level contains a `name` field that describes the topic of the level and a `questions` object that groups questions by question type.

Within the `questions` object, questions are separated into categories such as `multiple-choice`, `drap-and-drop`, and `matching`.

### Multiple-Choice Questions

Each multiple-choice question contains:

* `question`: The question shown to the player.
* `options`: An array containing all possible answer choices.
* `answer`: An array containing the correct answer or answers.
* `explanation`: An optional field that can provide additional information after the player answers the question.

The `answer` field is stored as an array so that the structure can support both single-answer and multiple-answer questions.

### Drag-and-Drop Questions

Drag-and-drop questions contain:

* `question`: The instructions or prompt shown to the player.
* `orientation`: Determines whether the draggable items should be displayed `horizontal` or `vertical`.
* `answer`: An ordered array representing the correct arrangement of the draggable items.

Because the order of the `answer` array represents the correct solution, the game can compare the player's final arrangement against this sequence.

### Matching Questions

Matching questions contain:

* `question`: The prompt shown to the player.
* `columns`: A two-element array containing the labels for the two matching columns.
* `fixed`: An array containing the items displayed in the first, fixed column.
* `answer`: An array containing the correct corresponding items for the second column.

The first element of `columns` describes the values stored in `fixed`, while the second element describes the values stored in `answer`. Matches are determined by array position: `fixed[0]` corresponds to `answer[0]`, `fixed[1]` corresponds to `answer[1]`, and so on.

For example, if the structure is:

```json
"columns": ["Role", "Register"],
"fixed": [
    "Destination register",
    "First source register",
    "Second source register"
],
"answer": [
    "x7",
    "x5",
    "x6"
]
```

then `"Destination register"` matches with `"x7"`, `"First source register"` matches with `"x5"`, and `"Second source register"` matches with `"x6"`.

Overall, this structure allows each level to contain different types of interactive questions while keeping the format predictable for the game to load, display, and evaluate.
