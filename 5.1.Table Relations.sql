-- 1. Mountains and Peaks
CREATE table mountains (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE table peaks (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    mountain_id INT,
    CONSTRAINT fk_peaks_mountains_id
    FOREIGN KEY(mountain_id) REFERENCES mountains(id)
);