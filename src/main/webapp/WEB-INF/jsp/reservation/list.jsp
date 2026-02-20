<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des R&eacute;servations</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .filter-form { margin-bottom: 20px; padding: 15px; background-color: #f5f5f5; border-radius: 5px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .no-data { text-align: center; padding: 20px; font-style: italic; color: #666; }
    </style>
</head>
<body>

    <h1>Liste des R&eacute;servations</h1>

    <div class="filter-form">
        <form action="reservations" method="get">
            <label for="date">Filtrer par date:</label>
            <input type="date" id="date" name="date" value="${date}">
            <button type="submit">Rechercher</button>
            <a href="reservations"><button type="button">Effacer le filtre</button></a>
        </form>
    </div>

    <c:if test="${not empty reservations}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Client</th>
                    <th>Passagers</th>
                    <th>Date d'Arriv&eacute;e</th>
                    <th>H&ocirc;tel</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="reservation" items="${reservations}">
                    <tr>
                        <td>${reservation.id}</td>
                        <td>${reservation.idClient}</td>
                        <td>${reservation.nombrePassager}</td>
                        <td>${reservation.dateArrive}</td>
                        <td>${reservation.hotel.nom}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty reservations}">
        <div class="no-data">
            Aucune r&eacute;servation trouv&eacute;e <c:if test="${not empty date}"> pour la date du ${date}</c:if>.
        </div>
    </c:if>

</body>
</html>
