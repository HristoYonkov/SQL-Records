-- 01. Records’ Count
SELECT COUNT(*) FROM wizzard_deposits;

-- 02. Longest Magic Wand
SELECT MAX(magic_wand_size) AS longest_magic_wand FROM wizzard_deposits;

-- 03. Longest Magic Wand per Deposit Groups
SELECT deposit_group AS deposit_group, MAX(magic_wand_size) AS magic_wand_size FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY magic_wand_size, deposit_group;