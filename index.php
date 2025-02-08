<?php
require 'database.php';

$sql = "
    SELECT dances.dance_name, dances.description, dances.region, media.media_url, media.alttext, dance_categories.category_name
    FROM dances
    LEFT JOIN media ON dances.media_id = media.media_id
    LEFT JOIN dance_categories ON dances.category_id = dance_categories.category_id
";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Brazilian Dances</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        img {
            max-width: 150px;
            height: auto;
        }
    </style>
</head>
<body>
    <h1>Brazilian Dances</h1>

    <?php if ($result->num_rows > 0): ?>
        <table>
            <thead>
                <tr>
                    <th>Dance Name</th>
                    <th>Description</th>
                    <th>Category</th>
                    <th>Region</th>
                    <th>Image</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['dance_name']); ?></td>
                        <td><?php echo htmlspecialchars($row['description']); ?></td>
                        <td><?php echo htmlspecialchars($row['category_name']); ?></td>
                        <td><?php echo htmlspecialchars($row['region']); ?></td>
                        <td>
                            <?php if (!empty($row['media_url'])): ?>
                                <img src="<?php echo htmlspecialchars($row['media_url']); ?>" alt="<?php echo htmlspecialchars($row['alttext']); ?>">
                            <?php else: ?>
                                No Image Available
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>No dances found.</p>
    <?php endif; ?>

    <?php
    $conn->close();
    ?>
</body>
</html>
