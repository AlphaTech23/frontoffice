<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="com.example.frontoffice.model.Reservation"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Réservations</title>
    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        /* En-tête */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5em;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: -0.5px;
        }

        .header p {
            font-size: 1.1em;
            opacity: 0.9;
        }

        /* Filtre */
        .filter-section {
            background: #f8f9fa;
            padding: 25px;
            border-bottom: 1px solid #e9ecef;
        }

        .filter-form {
            display: flex;
            align-items: flex-end;
            gap: 15px;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            min-width: 250px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-family: 'Inter', sans-serif;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102,126,234,0.3);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        /* Statistiques */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            padding: 25px;
            background: white;
        }

        .stat-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 2.5em;
            color: #667eea;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 2em;
            font-weight: 700;
            color: #495057;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Tableau */
        .table-container {
            padding: 0 25px 25px 25px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        thead tr {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th {
            padding: 15px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
            letter-spacing: 0.5px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
            color: #495057;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .badge-hotel {
            background: linear-gradient(135deg, #667eea20 0%, #764ba220 100%);
            color: #667eea;
        }

        .badge-passagers {
            background: #28a74520;
            color: #28a745;
        }

        /* Message aucune donnée */
        .no-data {
            text-align: center;
            padding: 50px 25px;
            background: #f8f9fa;
            border-radius: 15px;
            margin: 25px;
        }

        .no-data i {
            font-size: 4em;
            color: #dee2e6;
            margin-bottom: 15px;
        }

        .no-data p {
            color: #6c757d;
            font-size: 1.2em;
            margin-bottom: 10px;
        }

        .no-data .date-highlight {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            display: inline-block;
            font-weight: 600;
        }

        /* Footer */
        .footer {
            background: #f8f9fa;
            padding: 15px 25px;
            text-align: center;
            color: #6c757d;
            font-size: 0.9em;
            border-top: 1px solid #e9ecef;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.8em;
            }
            
            .filter-form {
                flex-direction: column;
            }
            
            .form-group {
                width: 100%;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- En-tête -->
        <div class="header">
            <h1><i class="fas fa-calendar-check" style="margin-right: 10px;"></i>Gestion des Réservations</h1>
            <p>Consultez et filtrez l'ensemble des réservations</p>
        </div>

        <!-- Section filtre -->
        <div class="filter-section">
            <form action="reservations" method="get" class="filter-form">
                <div class="form-group">
                    <label for="date">
                        <i class="fas fa-calendar-alt" style="margin-right: 5px;"></i>
                        Filtrer par date
                    </label>
                    <input type="date" id="date" name="date" 
                           value="<%= request.getAttribute("date") != null ? request.getAttribute("date") : "" %>"
                           placeholder="Sélectionner une date">
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i>
                    Rechercher
                </button>
                <a href="reservations" class="btn btn-secondary">
                    <i class="fas fa-times"></i>
                    Effacer le filtre
                </a>
            </form>
        </div>

<%
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
    
    // Calcul des statistiques
    int totalReservations = reservations != null ? reservations.size() : 0;
    int totalPassagers = 0;
    String hotelPlusReserve = "";
    int maxReservations = 0;
    
    if (reservations != null) {
        java.util.Map<String, Integer> hotelCount = new java.util.HashMap<>();
        for (Reservation r : reservations) {
            totalPassagers += r.getNombrePassager();
            String hotelNom = r.getHotel() != null ? r.getHotel().getNom() : "Non spécifié";
            hotelCount.put(hotelNom, hotelCount.getOrDefault(hotelNom, 0) + 1);
        }
        
        for (java.util.Map.Entry<String, Integer> entry : hotelCount.entrySet()) {
            if (entry.getValue() > maxReservations) {
                maxReservations = entry.getValue();
                hotelPlusReserve = entry.getKey();
            }
        }
    }
%>

        <!-- Statistiques -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-ticket-alt"></i>
                </div>
                <div class="stat-value"><%= totalReservations %></div>
                <div class="stat-label">Réservations</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value"><%= totalPassagers %></div>
                <div class="stat-label">Passagers</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-hotel"></i>
                </div>
                <div class="stat-value"><%= hotelPlusReserve.isEmpty() ? "-" : hotelPlusReserve %></div>
                <div class="stat-label">Hôtel le + réservé</div>
            </div>
        </div>

<%
    if (reservations != null && !reservations.isEmpty()) {
        // Formateur pour les dates
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
        <!-- Tableau des réservations -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag" style="margin-right: 5px;"></i>ID</th>
                        <th><i class="fas fa-user" style="margin-right: 5px;"></i>Client</th>
                        <th><i class="fas fa-users" style="margin-right: 5px;"></i>Passagers</th>
                        <th><i class="fas fa-calendar-alt" style="margin-right: 5px;"></i>Date d'Arrivée</th>
                        <th><i class="fas fa-hotel" style="margin-right: 5px;"></i>Hôtel</th>
                    </tr>
                </thead>
                <tbody>
<%
        for (Reservation reservation : reservations) {
            // Formatage de la date si disponible
            LocalDateTime dateArrivee = reservation.getDateArrive();
            String dateArriveeFormatted = "";
            if (dateArrivee != null) {
                dateArriveeFormatted = dateArrivee.format(formatter);
            }
%>
                    <tr>
                        <td><strong>#<%= reservation.getId() %></strong></td>
                        <td>
                            <i class="fas fa-user-circle" style="color: #667eea; margin-right: 5px;"></i>
                            <%= reservation.getIdClient() %>
                        </td>
                        <td>
                            <span class="badge badge-passagers">
                                <i class="fas fa-user"></i> <%= reservation.getNombrePassager() %>
                                <%= reservation.getNombrePassager() > 1 ? "passagers" : "passager" %>
                            </span>
                        </td>
                        <td>
                            <i class="far fa-calendar" style="color: #6c757d; margin-right: 5px;"></i>
                            <%= dateArriveeFormatted %>
                        </td>
                        <td>
                            <span class="badge badge-hotel">
                                <i class="fas fa-building"></i>
                                <%= reservation.getHotel() != null ? reservation.getHotel().getNom() : "Non spécifié" %>
                            </span>
                        </td>
                    </tr>
<%
        }
%>
                </tbody>
            </table>
        </div>
<%
    } else {
%>
        <!-- Message aucune donnée -->
        <div class="no-data">
            <i class="fas fa-folder-open"></i>
            <p>Aucune réservation trouvée</p>
<%
        if (request.getAttribute("date") != null) {
            String dateFiltre = (String) request.getAttribute("date");
            try {
                LocalDate date = LocalDate.parse(dateFiltre);
                DateTimeFormatter formatterDate = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                dateFiltre = date.format(formatterDate);
            } catch (Exception e) {
                // Garder la date originale si le formatage échoue
            }
%>
            <div class="date-highlight">
                <i class="fas fa-calendar-day"></i>
                pour le <%= dateFiltre %>
            </div>
<%
        }
%>
        </div>
<%
    }
%>

        <!-- Footer -->
        <div class="footer">
            <p>
                <i class="far fa-clock"></i>
                Dernière mise à jour : <%= java.time.LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")) %>
            </p>
        </div>
    </div>
</body>
</html>